-module(transaction).

-export([print_header/0, print/1]).

-import(cli, [pad/1, pad/2, print_values/1, print_values/2]).

print_header() ->
    print_values([pad("ID", 5), pad("Name", 50), pad("Purchased"), pad("Vendor")], header).

print(#{id := ID, name := Name, purchased := Purchased, vendor := Vendor}) ->
    print_values([pad(ID, 5), pad(Name, 50), pad(Purchased), pad(Vendor)]).

