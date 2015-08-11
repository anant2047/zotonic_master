-module(controller_logon_using_mobile).

-export([generate_otp/0,generate_otp1/1,set_otp/2,send_email_with_mfa_otp/3,delete_otp/2,get_otp/2,get_by_otp/2]).
-export([event/2]).
-include_lib("controller_webmachine_helper.hrl").
-include_lib("include/zotonic.hrl").

-define(LOGON_REMEMBERME_COOKIE, "z_logon").
-define(LOGON_REMEMBERME_DAYS, 365).

event({submit, otp_form_verified, _FormId, _TagerId}, Context) ->
   UserId1=z_context:get_q("UserId", Context),
   {UserId,_}=string:to_integer(UserId1),
    OTP1 = erlang:list_to_binary(z_string:trim(z_context:get_q("otp1", Context))),
    OTP2 = controller_logon_using_mobile: get_otp( UserId,Context),

    case {OTP1,OTP2} of
        {P,P} ->
            case m_identity:get_username(UserId, Context) of
                undefined ->
                    throw({error, "User does not have an username defined."});
                 _Else ->    
           
                          ContextLoggedon =controller_logon: logon_user(UserId, Context),
                        controller_logon_using_mobile:delete_otp(UserId, ContextLoggedon),
                        ContextLoggedon
            end;
            
        {_,_} ->
           
            z_render:wire({redirect, [{location, "/logon/otp-form/error"  }]}, Context)
    end.


generate_otp()->
	generate_otp1(erlang:binary_to_list(crypto:rand_bytes(4))).

generate_otp1([])->1;

generate_otp1([Value|Tail])->
	case Value of
		0		->generate_otp1(Tail);
		_Else	->Value*generate_otp1(Tail)
	end.


set_otp(Id, Context) ->
    Login_otp = generate_otp(),
    m_identity:set_by_type(Id, "logon_otp_value", Login_otp, Context),
    Login_otp.

send_email_with_mfa_otp(Email, Vars, Context) ->
    z_email:send_render(Email, "email_mfa_otp.tpl", Vars, Context),
     ok.


delete_otp(Id, Context) ->
    Key=erlang:binary_to_integer(get_otp( Id,Context)),
    m_identity:delete_by_type_and_key(Id, "logon_otp_value", Key, Context) .
    


get_otp(Login_otp, Context) ->
    case m_identity:get_rsc_by_type( Login_otp,"logon_otp_value", Context) of
        undefined -> undefined;
         [Row | _] ->  proplists:get_value(key, Row)
    end.

    

get_by_otp(Code, Context) ->
    case m_identity:lookup_by_type_and_key("logon_otp_value", Code, Context) of
        undefined -> undefined;
        Row -> {ok, proplists:get_value(rsc_id, Row)}
    end.





