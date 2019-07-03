-module(srv).
-export([go/0, loop/0]).

go() ->
    Pid = spawn(srv, loop, []),
    Pid ! {self(), hello},
    receive
        {Pid, Msg} -> 
            io:format("~w~n", [Msg])
    end,
    Pid ! stop.


loop() ->
    receive
        {De, Msg} ->
            De ! {self(), Msg},
            loop();
        stop ->
            true
    end.
