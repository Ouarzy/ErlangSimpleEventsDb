-module(db_test).

-include_lib("eunit/include/eunit.hrl").

any_test() -> ?assertEqual(db:hello(), hello).

