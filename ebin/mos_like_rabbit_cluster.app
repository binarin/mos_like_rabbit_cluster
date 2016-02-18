{application, mos_like_rabbit_cluster, [
	{description, "New project"},
	{vsn, "0.0.1"},
	{modules, ['mos_like_rabbit_cluster_app','mos_like_rabbit_cluster_sup','mos_like_rpc_server','sut']},
	{registered, [mos_like_rabbit_cluster_sup]},
	{applications, [kernel,stdlib,amqp_client,proper]},
	{mod, {mos_like_rabbit_cluster_app, []}}
]}.