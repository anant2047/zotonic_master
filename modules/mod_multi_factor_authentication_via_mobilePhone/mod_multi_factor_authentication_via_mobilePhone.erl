-module(mod_multi_factor_authentication_via_mobilePhone).

-mod_title("Multi-factor authentication via mobile phone").
-mod_description("Can only be used when multi-factor authentication via email is deactivated. Provides extra layer of security by sending otp to mobile phone").
-mod_prio(350).

-export([check_activation/1]).


check_activation(Context)->
	case   z_module_manager:active(mod_multi_factor_authentication_via_mobilePhone, Context) of
		true->yes;
		false->no
	end.
