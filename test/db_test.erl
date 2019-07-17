-module(db_test).

-include_lib("eunit/include/eunit.hrl").


new_test() -> ?assertEqual(db:new(), events).

appendToStream_test() -> 
    ExpectedStreamId =uuid:uuid1(),
    ?assertEqual(true, db:appendToStream(ExpectedStreamId, {messageTweeted, "hello"})).


getEventsByStreamOnExistingStream_test() -> 
    ExpectedStreamId =uuid:uuid1(),
   % db:new(),
    db:appendToStream(ExpectedStreamId, {messageTweeted, "hello"}),
    db:appendToStream(ExpectedStreamId, {messageDeleted}),
    ?assertEqual({ok, [{messageTweeted, "hello"}, {messageDeleted}]}, db:getEventsByStream(ExpectedStreamId)).

getEventsByStreamOnNotExistingStream_test() ->
   % db:new(),
 ?assertEqual({error, stream_does_not_exist}, db:getEventsByStream(uuid:uuid1())).
