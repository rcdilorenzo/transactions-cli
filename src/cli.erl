-module(cli).

-export([print_values/1, print_values/2, pad/1, pad/2]).

print_values(Values) when is_list(Values) ->
    String = "| " ++ join(Values, " | ") ++ " |\n",
    io:format(String),
    String.

print_values(Values, header) ->
    String = print_values(Values),
    io:format(repeat_pad("-", length(String)-1) ++ "\n").

repeat_pad(String, Pad) ->
    repeat_pad(String, "", Pad).
repeat_pad(Base, String, Pad) when length(String) < Pad ->
    repeat_pad(Base, String ++ Base, Pad);
repeat_pad(_, String, Pad) when length(String) >= Pad -> String.

pad(String) ->
    pad(String, 12).

pad(Integer, Pad) when is_integer(Integer) ->
    pad(integer_to_list(Integer), Pad);
pad(String, Pad) when is_binary(String) ->
    pad(binary_to_list(String), Pad);
pad(String, Pad) when length(String) < Pad, Pad > 3 ->
    pad(String ++ " ", Pad);
pad(String, Pad) when length(String) == Pad, Pad > 3 ->
    String;
pad(String, Pad) when length(String) > Pad, Pad > 3 ->
    string:substr(String, 1, Pad-3) ++ "...".

join([X|Xs], [])  -> join0(X, Xs);
join([X|Xs], [C]) -> join1(X, C, Xs);
join([X|Xs], Sep) -> join2(X, Sep, Xs);
join([],     _)   -> [].

join0(X, [Y|Ys]) -> X ++ join0(Y, Ys);
join0(X, [])     -> X.

join1(X, C, [Y|Ys]) -> X ++ [C|join1(Y, C, Ys)];
join1(X, _, [])     -> X.

join2(X, Sep, [Y|Ys]) -> X ++ (Sep ++ join2(Y, Sep, Ys));
join2(X, _,   [])     -> X.
