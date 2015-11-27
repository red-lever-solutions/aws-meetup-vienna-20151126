#!/bin/bash

echo "Configuring Consul Server ..."
cat > /etc/default/consul-server <<EOF
CONSUL_FLAGS="-retry-join 10.0.5.10 -retry-join 10.0.6.10 -retry-join 10.0.7.10 -bootstrap-expect=3 -log-level=debug"
EOF

cp /tmp/bootstrap/consul-server.conf /etc/init/consul-server.conf
service consul-server start
