#!/bin/bash

while true; do
    vagrant destroy -f
    if APT_PROXY_URL=http://10.10.10.1:3142/ vagrant up --provider virtualbox n1; then
        if [[ $(vagrant ssh n1 -c "ls /var/crash" | wc -l) -gt 0 ]]; then
            break
        fi
    fi
done
