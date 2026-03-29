#!/bin/bash
set -eux

docker build --progress=plain \
--no-cache \
-t registry.cn-shanghai.aliyuncs.com/odboy/devops:kenaito-pilot_production_202603232026 \
-f Dockerfile_production .
