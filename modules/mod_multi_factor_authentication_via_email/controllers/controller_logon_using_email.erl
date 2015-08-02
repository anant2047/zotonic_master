-module(controller_logon_using_email).
-export([send_mfa/2,set_uuid/2,generate_uuid/0,send_email_with_mfa/3]).
-export([delete_uuid/2,get_uuid/2,get_by_uuid/2,find_email/2]).


send_mfa(Ids, Context) ->
	debugger:start(),
    case find_email(Ids, Context) of
        undefined -> 
            controller_logon:logon_error("reminder", Context);
        Email -> 
            case m_identity:get_username(Ids, Context) of
                undefined ->
                   controller_logon: logon_error("reminder", Context);
                Username ->
                    Vars = [
                        {recipient_id, Ids},
                        {id, Ids},
                        {uuid, set_uuid(Ids,Context)},
                        {username, Username},
                        {email, Email}
                    ],
                    send_email_with_mfa(Email, Vars, Context)
            end
    end.


set_uuid(Id, Context) ->
    Login_uuid = generate_uuid(),
    m_identity:set_by_type(Id, "logon_uuid", Login_uuid, Context),
    Login_uuid.


generate_uuid() ->
<<A:16>>=crypto:rand_bytes(2),  
<<B:16>>=crypto:rand_bytes(2),
<<C:16>>=crypto:rand_bytes(2),
<<D:16>>=crypto:rand_bytes(2),
STORE=io_lib:format("~4.16.0B-~4.16.0B-~4.16.0B-~4.16.0B",[A, B, C , D]),
list_to_binary(STORE).

send_email_with_mfa(Email, Vars, Context) ->
    z_email:send_render(Email, "email_mfa.tpl", Vars, Context),
     ok.


    
delete_uuid(Id, Context) ->
    m_identity:delete_by_type(Id, "logon_uuid", Context).
    

get_uuid(Login_uuid, Context) ->
    case m_identity:lookup_by_type_and_key("logon_uuid", Login_uuid, Context) of
        undefined -> undefined;
        Row -> {ok, proplists:get_value(rsc_id, Row)}
    end.

get_by_uuid(Code, Context) ->
    case m_identity:lookup_by_type_and_key("logon_uuid", Code, Context) of
        undefined -> undefined;
        Row -> {ok, proplists:get_value(rsc_id, Row)}
    end.

find_email(Id, Context) ->
    m_rsc:p_no_acl(Id, email, Context).



