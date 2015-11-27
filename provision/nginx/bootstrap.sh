#!/bin/bash

HOSTNAME=`hostname`

mkdir -p /opt/nginx/data
cat >/opt/nginx/data/index.html <<EOF
<!doctype html>
<html>
<head><title>Hello, AWS enthusiasts!</title></head>
<body>
<p>
Hi, this is <strong>${HOSTNAME}</strong> speaking!
</p>
</body>
</html>
EOF

cp /tmp/bootstrap/docker-compose.yml /opt/nginx
cp /tmp/bootstrap/start.sh /opt/nginx
cd /opt/nginx
./start.sh
