-module(sut).

-include("include/sut.hrl").
-include_lib("amqp_client/include/amqp_client.hrl").

-compile([export_all]).

default() ->
    #sut{nodes = ["10.10.10.2", "10.10.10.3", "10.10.10.4"]}.

random(N) ->
    case get(random_seed) of
        undefined ->
            random:seed(erlang:phash2([node()]),
                        erlang:monotonic_time(),
                        erlang:unique_integer());
        _ -> ok
    end,
    random:uniform(N).

random_sut_node(#sut{nodes = Nodes}) ->
    lists:nth(random(length(Nodes)), Nodes).

amqp_connect(Sut) ->
    Node = random_sut_node(Sut),
    {ok, Connection} = amqp_connection:start(#amqp_params_network{host = Node, heartbeat = 20}),
    link(Connection),
    {ok, Channel} = amqp_connection:open_channel(Connection),
    {ok, Connection, Channel}.




-include_lib("eunit/include/eunit.hrl").

random_sut_nodes_test() ->
    Nodes = ["1", "2", "3"],
    Sut = #sut{nodes = Nodes},
    ?assert(lists:member(random_sut_node(Sut), Nodes)).
