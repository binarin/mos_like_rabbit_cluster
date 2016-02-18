#!/bin/bash
#!/bin/bash
set -eux
exec 2>&1

cat <<EOF > /etc/security/limits.conf
*               soft    core            100000
root            hard    core            100000
EOF
