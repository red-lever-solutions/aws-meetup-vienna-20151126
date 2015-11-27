#!/bin/bash

docker run --rm -i \
       --device /dev/fuse \
       --cap-add SYS_ADMIN \
       -v $(pwd)/provision:/source \
       -e BUCKET=aws-meetup-deploy \
       -e AWS_KEY="<AWS_KEY>" \
       -e AWS_SECRET="<AWS_SECRET>" \
       -e S3CMD="rm -rf /s3bucket/* && cp -v -r /source/* /s3bucket" \
       wernerwws/docker-s3
