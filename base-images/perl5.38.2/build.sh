#!/bin/bash
set -eux

IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-perl5.38.2"

echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .