#!/bin/bash

mkdir -p /opt/loadbalancer
cp -r /tmp/bootstrap/haproxy-template /opt/loadbalancer
cp /tmp/bootstrap/docker-compose.yml /opt/loadbalancer
cp /tmp/bootstrap/start.sh /opt/loadbalancer
cd /opt/loadbalancer
./start.sh
