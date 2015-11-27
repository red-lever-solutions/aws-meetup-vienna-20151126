#!/bin/bash

export PRIVATE_IP="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"

docker-compose up -d
