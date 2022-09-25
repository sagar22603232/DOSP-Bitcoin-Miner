-module(mainserver).
-import(string, [
    len/1,
    concat/2,
    chr/2,
    substr/3,
    str/2,
    to_lower/1,
    to_upper/1
]).
-export([start/2]).
start(ServerName, NumberofActors) ->
    net_adm:ping(ServerName),
    MinerServerId = rpc:call(ServerName, erlang, whereis, [server]),
    io:fwrite("~p\n", [MinerServerId]),
    register(server, self()),

    MinerServerId ! {self(), {request}},
    receive
        {ServerId, {NumOfZeroes}} ->
            bossactor(NumOfZeroes, NumberofActors, MinerServerId),
            ServerId
    end.

while([H | T], Count1) ->
    if
        H == 48 ->
            while(T, Count1 + 1);
        true ->
            Count1
    end;
while([], Count1) ->
    Count1.
for(N, N, F) ->
    [F()];
for(I, N, F) ->
    io:format("actor created: ~w~n", [I]),
    [F() | for(I + 1, N, F)].
getrandomstring(Length, AllowedChars) ->
    lists:foldl(
        fun(_, Acc) ->
            [
                lists:nth(
                    rand:uniform(length(AllowedChars)),
                    AllowedChars
                )
            ] ++
                Acc
        end,
        [],
        lists:seq(1, Length)
    ).

generateString() ->
    String1 = concat("s.parikh", getrandomstring(9, "1234567890")),
    String1.

generateHashValue(String2) ->
    Secret = crypto:hash(sha256, String2),
    Secret.

generateHexValue(HashString) ->
    <<SHA256:256/big-unsigned-integer>> = HashString,
    HexString = io_lib:format("~64.16.0b", [SHA256]),
    HexString.

countZeros(HS, check) ->
    Counter = while(HS, 0),
    Counter.

bitCoinMining(-1, MinerServerId) ->
    io:fwrite("We have found the match.\n"),
    io:fwrite("Letting Supervisor know.\n"),

    MinerServerId ! {self(), {finished}},
    receive
        {ServerId, {ok}} ->
            ServerId,
            io:fwrite("Stopped the execution.\n")
    end;

bitCoinMining(N, MinerServerId) ->
    TargetFormat = "0x00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
    String2 = generateString(),
    HashString = generateHashValue(String2),
    HexString = generateHexValue(HashString),
    Count = countZeros(HexString, check),
    if
        Count >= N ->
            if
                TargetFormat > HexString ->
                    io:fwrite("~p\n", [String2]),
                    io:fwrite("~p \n", [HexString]),
                    bitCoinMining(-1, MinerServerId);

                true ->
                    bitCoinMining(N, MinerServerId)
            end;
        Count < N ->
            bitCoinMining(N, MinerServerId)
    end.

bossactor(Num, NumberofActors, MinerServerId) ->
    for(1, NumberofActors, fun() -> spawn(fun() -> bitCoinMining(Num, MinerServerId) end) end).
