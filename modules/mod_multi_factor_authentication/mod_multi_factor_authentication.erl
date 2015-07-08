-module(mod_multi_factor_authentication).
-export([set_variable/1]).
-mod_prio(300).

set_variable(Context)->
	case   z_module_manager:active(mod_multi_factor_authentication, Context) of
	true->yes;
	false->no
	end.
