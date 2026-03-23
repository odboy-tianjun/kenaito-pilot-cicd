#!/bin/bash
set -eux

docker build --progress=plain \
--no-cache \
-t registry.cn-shanghai.aliyuncs.com/odboy/devops:kenaito-pilot_daily_202603232026 \
--build-arg APP_NAME=kenaito-pilot \
--build-arg ENV_CODE=dev \
-f Dockerfile_daily .
