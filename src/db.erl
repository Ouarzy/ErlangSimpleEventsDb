-module(db).

-export([new/0]).
-export([appendToStream/3]).

new() ->
    io:fwrite("creating new db\n"),
    [].

appendToStream(Db, StreamId, Event) -> 
    NewDb = lists:append(Db, [{StreamId, [Event]}]),
    NewDb.
