-module(mod_multi_factor_authentication_via_email).
-mod_depends([mod_authentication]).

-author("Anant Sharma <anant.2047@gmail.com>").
-mod_title("Multi-factor authentication via email").
-mod_description("Provides extra layer of security by authenticating using user's email address.").
-mod_prio(300).

-export([check_activation/1]).

check_activation(Context)->
	case   z_module_manager:active(mod_multi_factor_authentication_via_email, Context) of
		true->yes;
		false->no
	end.
