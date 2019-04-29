-module(db).

-export([new/0]).
-export([append/2]).

new() ->
    io:fwrite("creating new db\n"),
    [].

append(Event, Db) ->
    NewDb = lists:append(Db, [Event]),
    NewDb.
