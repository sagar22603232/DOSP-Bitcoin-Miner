-module(mainserver).
-import(string, [len/1,concat/2,chr/2,substr/3,str/2,
                to_lower/1,to_upper/1]).
-export([main/0,minner/0,bitCoinMining/1]).

while([H | T], Count1) ->
    if H == 48 ->
        while(T,Count1 + 1);
    true ->
        Count1
    end;
while([],Count1) -> Count1.

getrandomstring(Length, AllowedChars) ->
    lists:foldl(fun(_, Acc) ->
                        [lists:nth(rand:uniform(length(AllowedChars)),
                                    AllowedChars)]
                            ++ Acc
                end, [], lists:seq(1, Length)).

generateString() ->
    String1 = concat("s.parikh",getrandomstring(9,"1234567890")),
    io:fwrite("~p\n",[String1]),
    String1.

generateHashValue(String2) ->
    Secret = crypto:hash(sha256,String2),
    Secret.

generateHexValue(HashString) ->
    <<SHA256:256/big-unsigned-integer>> = HashString,
    HexString = io_lib:format("~64.16.0b", [SHA256]),
    HexString.

countZeros(HS, check) -> 
    Counter = while(HS,0),
    Counter.

bitCoinMining (N) ->
        TargetFormat = "0x00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
        String2 = generateString(),
        HashString = generateHashValue(String2),
        HexString = generateHexValue(HashString),
        io:fwrite("~p \n",[HexString]),
        Count = countZeros(HexString, check),
        io:fwrite("Number of Zeros are ~p\n",[Count]),
        if 
            Count >= N ->
                if
                    TargetFormat > HexString ->
                        io:fwrite("We have found\n");
                    true ->
                        io:fwrite("We have not found\n")
                end;
            Count < N ->
                io:fwrite("We have not found\n")
        end.

minner() ->
    receive
        {Client, Num} ->
            Client ! bitCoinMining(Num),
    minner()
        end.

        

main() ->
    spawn(fun minner/0).





