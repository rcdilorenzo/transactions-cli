-module(client).

-export([list/0]).

base() -> "http://localhost:3000".

list() ->
    {ok, {{_, 200, _}, _, Body}} = httpc:request(base() ++ "/transactions"),
    TransactionMaps = jsx:decode(list_to_binary(Body), [return_maps, {labels, atom}]),
    transaction:print_header(),
    lists:foreach(fun transaction:print/1, TransactionMaps).
