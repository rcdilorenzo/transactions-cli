-module(transactions).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, main/1]).

main([String]) ->
    inets:start(),
    case String of
        "list" -> client:list();
        _ -> usage()
    end;

main(_) ->
    usage().

usage() ->
    io:format("usage: factorial integer\n"),
    halt(1).

fac(0) -> 1;
fac(N) -> N * fac(N-1).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    transactions_sup:start_link().

stop(_State) ->
    ok.
