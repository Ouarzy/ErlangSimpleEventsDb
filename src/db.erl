-module(db).

-export([new/0, appendToStream/3, getEventsByStream/2]).

new() ->
    io:fwrite("creating new db\n"),
    [].

appendToStream(Db, StreamId, Event) -> 
    NewDb = lists:append(Db, [{StreamId, Event}]),
    NewDb.

getEventsByStream(Db, StreamId) ->
    EventsByStream = lists:filtermap(
                       fun({_StreamId, Event}) -> 
                            if _StreamId == StreamId -> { true, Event };
                            _StreamId /= StreamId -> false
                            end
                       end,
                       Db),
    {StreamId, EventsByStream}.
