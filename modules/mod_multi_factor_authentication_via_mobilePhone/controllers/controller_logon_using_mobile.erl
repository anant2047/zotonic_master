-module(controller_logon_using_mobile).

-export([generate_otp/0,generate_otp1/1,send_mfa_otp/2,set_otp/2,send_email_with_mfa_otp/3,delete_otp/2,get_otp/2,get_by_otp/2]).
-export([event/2]).

-include_lib("controller_webmachine_helper.hrl").
-include_lib("include/zotonic.hrl").

event({submit, otp_form_verified, _FormId, _TagerId}, Context) ->
   UserId1=z_context:get_q("UserId", Context),
   {UserId,_}=string:to_integer(UserId1),

    OTP1 = erlang:list_to_binary(z_string:trim(z_context:get_q("otp1", Context))),
    OTP2 = get_otp( UserId,Context),
    
    case {OTP1,OTP2} of
        {P,P} ->
            case m_identity:get_username(UserId, Context) of
                undefined ->
                    throw({error, "User does not have an username defined."});
                 _Else ->    
           
                    [LogonArgs]=m_identity:get_rsc_by_type( UserId,"Logon_store", Context),
                    ?DEBUG(LogonArgs),
                    [LogonArgs_username]=m_identity:get_rsc_by_type( UserId,"Logon_store_username", Context),
                    ?DEBUG(LogonArgs_username),
                    [LogonArgs_password]=m_identity:get_rsc_by_type( UserId,"Logon_store_password", Context),
                    ?DEBUG(LogonArgs_password),
                    [LogonArgs_page]=m_identity:get_rsc_by_type( UserId,"Logon_store_page", Context),
                    ?DEBUG(LogonArgs_page),



                    Args=[{"triggervalue",[]},{"page",erlang:binary_to_list(proplists:get_value(key,LogonArgs_page))},{"handler","username"},{"username",erlang:binary_to_list(proplists:get_value(key,LogonArgs_username))},{"password",erlang:binary_to_list(proplists:get_value(key,LogonArgs_password))},{"rememberme",[]},{"z_v",erlang:binary_to_list(proplists:get_value(key,LogonArgs))}],
                    ?DEBUG(Args),

                    case z_notifier:first(#logon_submit{query_args=Args}, Context) of
                        {ok, UserId} when is_integer(UserId) -> 
                        controller_logon:logon_user(UserId, Context)
                    end

            end;

            
        {_,_} ->
            ?DEBUG(OTP1),
            ?DEBUG(OTP2),
            z_render:wire({redirect, [{location, "/logon/otp-form/error"  }]}, Context)
            % logon_error("unequalOtp", Context)
    end;

event({submit, mobile_number_submitted , _FormId, _TagerId}, Context) ->
	UserId1=z_context:get_q("UserId", Context),
	{UserId,_}=string:to_integer(UserId1),

	?DEBUG("in mobile event"),
 	Mobile_number=erlang:list_to_binary(z_string:trim(z_context:get_q("mobile_number", Context))),
 	?DEBUG(Mobile_number),

 	send_mfa_otp(UserId, Context),
	z_render:wire({redirect, [{location, "/logon/otp-form?UserId=" ++ erlang:integer_to_list(UserId) }]}, Context).


generate_otp()->
	generate_otp1(erlang:binary_to_list(crypto:rand_bytes(4))).

generate_otp1([])->1;

generate_otp1([Value|Tail])->
	case Value of
		0		->generate_otp1(Tail);
		_Else	->Value*generate_otp1(Tail)
	end.

send_mfa_otp(Ids, Context) ->
    case controller_logon:find_email(Ids, Context) of
        undefined -> 
            controller_logon:logon_error("reminder", Context);
        Email -> 
            case m_identity:get_username(Ids, Context) of
                undefined ->
                   controller_logon:logon_error("reminder", Context);
                Username ->
                    Vars = [
                        {recipient_id, Ids},
                        {id, Ids},
                        {otp, set_otp(Ids,Context)},
                        {username, Username},
                        {email, Email}
                    ],
                    send_email_with_mfa_otp(Email, Vars, Context)
            end
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





