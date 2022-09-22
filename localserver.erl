-module(localserver).
-export([start/2]).

start(Server, Num) ->
    Server ! {self(), Num},
    receive
        {Server, ResultString} ->
            ResultString
    end.