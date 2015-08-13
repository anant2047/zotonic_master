-module(mod_multi_factor_authentication_via_mobilePhone).
-mod_depends([mod_authentication]).

-mod_title("Multi-factor authentication via mobile phone").
-mod_description("Provides extra layer of security by authenticating using otp sent to mobile phone of the user").
-mod_prio(350).

-export([check_activation/1,deactivate_module/1]).


check_activation(Context)->
	case   z_module_manager:active(mod_multi_factor_authentication_via_mobilePhone, Context) of
		true->yes;
		false->no
	end.

deactivate_module(Context)->
	 z_module_manager:deactivate(mod_multi_factor_authentication_via_mobilePhone, Context).
