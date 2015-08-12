-module(mod_multi_factor_authentication_via_email).
-mod_depends([mod_authentication]).

-author("Anant Sharma <anant.2047@gmail.com>").
-mod_title("Multi-factor authentication via email").
-mod_description("Provides extra layer of security using user's email address. While activating this module mod_multi_factor_authentication_via_mobilePhone will automatically be deactivated.").
-mod_prio(300).

-export([check_activation/1]).

check_activation(Context)->
	case   z_module_manager:active(mod_multi_factor_authentication_via_email, Context) of
		true->yes;
		false->no
	end.
