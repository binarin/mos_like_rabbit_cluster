#!/bin/bash
set -ex
exec 2>&1 

APT_PROXY_URL=$1
if [[ ! -z $APT_PROXY_URL ]]; then
    echo Acquire::http::Proxy \"$APT_PROXY_URL\"\; > /etc/apt/apt.conf.d/proxy
fi

wget -O - http://mirror.fuel-infra.org/mos-repos/ubuntu/8.0/archive-mos8.0.key | apt-key add -

cat <<EOF > /etc/apt/sources.list.d/mos.list
deb http://mirror.fuel-infra.org/mos-repos/ubuntu/8.0/ mos8.0 main restricted
deb http://mirror.fuel-infra.org/mos-repos/ubuntu/8.0/ mos8.0-updates main restricted
deb http://mirror.fuel-infra.org/mos-repos/ubuntu/8.0/ mos8.0-security main restricted
deb http://mirror.fuel-infra.org/mos-repos/ubuntu/8.0/ mos8.0-holdback main restricted
EOF

apt-get update
locale-gen ru_RU.UTF-8
