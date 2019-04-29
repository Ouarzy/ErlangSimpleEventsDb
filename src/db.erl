-module(db).

-export([hello/0]).

hello() ->
    io:fwrite("hello\n"),
    hello.
