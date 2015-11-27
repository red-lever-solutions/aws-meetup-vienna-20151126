#!/bin/bash

sleep 5

set -e

CONSUL_CONNECT=${CONSUL_CONNECT:-127.0.0.1:8500}

eval consul-template \
     -config /consul-template/config.d \
     -consul $CONSUL_CONNECT \
     -wait 2s:10s \
     -log-level debug
