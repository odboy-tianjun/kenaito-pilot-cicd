#!/bin/bash
set -eux

PYTHON_FILE="Python-3.10.0.tgz"
IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-python3.10.0"

if [ ! -f "$PYTHON_FILE" ]; then
    echo "PYTHON压缩包不存在，开始下载..."
    curl -O https://www.python.org/ftp/python/3.10.0/$PYTHON_FILE
else
    echo "PYTHON压缩包已存在，跳过下载"
fi

#./configure --enable-optimizations --with-ssl --prefix=/usr/local/python3
echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .