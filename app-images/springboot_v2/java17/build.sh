#!/bin/bash
set -eux

IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:java17"

echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .
