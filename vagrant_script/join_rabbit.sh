#!/bin/bash
set -eux
exec 2>&1

rabbitmqctl stop_app
rabbitmqctl join_cluster rabbit@n1
rabbitmqctl start_app
