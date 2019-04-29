-module(db_test).

-include_lib("eunit/include/eunit.hrl").


new_test() -> ?assertEqual(db:new(), []).

append_test() -> 
    ExpectedStreamId =uuid:uuid1(),
    ?assertEqual([{ExpectedStreamId, [{messageTweeted, "hello"}]}], db:appendToStream(db:new(), ExpectedStreamId, {messageTweeted, "hello"})).



