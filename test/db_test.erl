-module(db_test).

-include_lib("eunit/include/eunit.hrl").


new_test() -> ?assertEqual(db:new(), []).

append_test() -> 
    ExpectedUid =uuid:uuid1(),
    ?assert(db:append({messageTweeted, ExpectedUid}, db:new()), [{messageTweeted, ExpectedUid}]).



