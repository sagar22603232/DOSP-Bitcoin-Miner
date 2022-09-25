-module(localserver).
-export([serverStart/1]).
serverStart(NumOfZeroes) ->
    register(server, self()),
    receive
        {SupervisorId, {finished}} ->
            SupervisorId,
            io:fwrite("Stopping the execution");
        {SupervisorId, {request}} ->
            SupervisorId ! {self(), {NumOfZeroes}}
    end.
