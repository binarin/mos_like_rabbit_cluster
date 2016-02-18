#!/bin/bash
set -eux
exec 2>&1

rabbitmqctl set_policy ha-all "^ha-all\." '{"ha-mode":"all", "ha-sync-mode":"automatic"}'
