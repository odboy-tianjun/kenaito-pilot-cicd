#!/bin/bash
set -eux

bash build8.sh
bash build11.sh
bash build17.sh
bash build21.sh

IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-jdk"
echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .

echo "清理临时文件"
rm -f java8.tgz
rm -f java11tgz
rm -f java17.tgz
rm -f java21.tgz