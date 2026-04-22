-module(main).
-export([main/1]).

main(_) ->
    {ok, Binary} = file:read_file("/dev/stdin"),
    [A, B] = [list_to_integer(X) || X <- string:tokens(binary_to_list(Binary), " \n\r\t")],
    io:format("~B~n", [A + B]).