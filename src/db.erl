-module(db).

-export([new/0, appendToStream/2, getEventsByStream/1]).
-export([start/0, stopP/0, loop/1, appendToStreamP/2, getEventsByStreamP/1]).

start() ->
    case whereis(db) of
        undefined ->
            NewDb = new(),
            register(db,  spawn(db, loop, [NewDb])),
            io:fwrite("starting to rox the poneys\n"),
            ok;
        Pid when is_pid(Pid) ->
            {error, already_started}
    end.

appendToStreamP(StreamId, Event) ->
    db ! {self(), {appendToStream, StreamId, Event}},
    ok.
getEventsByStreamP(StreamId) ->
    db ! {self(), {getEventsByStream, StreamId}},
    receive
        {_From, Response} -> Response
    end.

stopP() ->
    io:fwrite("stopping\n"),
    db ! stop,
    ok.

 
loop(Db) ->
     receive
         {From, {appendToStream, StreamId, Event}} ->
            NewDb = appendToStream(StreamId, Event),
            From ! ok,
            loop(NewDb);
         {From, {getEventsByStream, StreamId}} ->
            EventsByStream = getEventsByStream(StreamId),
            From ! {ok, EventsByStream},            
            loop(Db);
         stop ->
            ok
     end.    


new() ->
    %io:fwrite("creating new db\n"),
    ets:new(events, [named_table]).

appendToStream(StreamId, Event) -> 
   Events =  case ets:lookup(events, StreamId) of
        [] ->  lists:append([], [Event]);
        [Head | _Tail] -> lists:append(element(2, Head), [Event])
    end,
    ets:insert(events, {StreamId, Events}).

getEventsByStream(StreamId) ->
    io:fwrite("getEvents by stream\n"),
    Events =  case ets:lookup(events, StreamId) of
        [] -> [];
        [Head | _Tail] -> element(2, Head)
    end,
    case Events of
        [] -> {error, stream_does_not_exist};
        Events -> {ok, Events}                          
    end.
