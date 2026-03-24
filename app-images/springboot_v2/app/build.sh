#!/bin/bash
set -eux

docker build --progress=plain \
--no-cache \
-t registry.cn-shanghai.aliyuncs.com/odboy/devops:kenaito-pilot_production_202603232026 \
--build-arg APP_NAME=kenaito-pilot \
--build-arg ENV_CODE=production \
-f Dockerfile_production .
