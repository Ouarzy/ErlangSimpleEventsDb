-module(db_test).

-include_lib("eunit/include/eunit.hrl").


new_test() -> ?assertEqual(db:new(), []).

appendToStream_test() -> 
    ExpectedStreamId =uuid:uuid1(),
    ?assertEqual([{ExpectedStreamId, {messageTweeted, "hello"}}], db:appendToStream(db:new(), ExpectedStreamId, {messageTweeted, "hello"})).


getEventsByStream_test() -> 
    ExpectedStreamId =uuid:uuid1(),
    Db = db:new(),
    DbWithTweeted = db:appendToStream(Db, ExpectedStreamId, {messageTweeted, "hello"}),
    DbWithDeleted = db:appendToStream(DbWithTweeted, ExpectedStreamId, {messageDeleted}),
    ?assertEqual({ExpectedStreamId, [{messageTweeted, "hello"}, {messageDeleted}]}, db:getEventsByStream(DbWithDeleted, ExpectedStreamId)).

