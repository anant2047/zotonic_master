-module(mod_multi_factor_authentication_via_mobilePhone).
-mod_depends([mod_authentication]).

-mod_title("Multi-factor authentication via mobile phone").
-mod_description("Can only be used when multi-factor authentication via email is deactivated and mobile number of user is saved in the database. Provides extra layer of security by sending otp to mobile phone").
-mod_prio(350).

-export([check_activation/1,deactivate_module/1]).


check_activation(Context)->
	case   z_module_manager:active(mod_multi_factor_authentication_via_mobilePhone, Context) of
		true->yes;
		false->no
	end.

deactivate_module(Context)->
	 z_module_manager:deactivate(mod_multi_factor_authentication_via_mobilePhone, Context).
