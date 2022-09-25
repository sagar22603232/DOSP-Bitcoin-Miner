-module(localserver).
-export([serverStart/1]).
serverStart(NumOfZeroes) ->
    register(server, self()),
    receive
        {SupervisorId, {request}} ->
        SupervisorId ! {self(), {NumOfZeroes}}
    end.