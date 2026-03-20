#!/bin/bash
set -eux

# 可选版本：3.9.9、3.11.13、3.12.11、3.13.7
PYTHON_VERSION="3.9.9"
PYTHON_FILE="Python-$PYTHON_VERSION.tgz"
PYTHON_OUTPUT="python3.tgz"
IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-python$PYTHON_VERSION"

if [ ! -f "$PYTHON_FILE" ]; then
    echo "PYTHON压缩包不存在，开始下载..."
    curl -O https://mirrors.huaweicloud.com/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
else
    echo "PYTHON压缩包已存在，跳过下载，并清理 $PYTHON_OUTPUT"
    rm -f $PYTHON_OUTPUT
fi

tar -xzvf $PYTHON_FILE
mv Python-$PYTHON_VERSION python3
tar -czvf $PYTHON_OUTPUT python3

#./configure --enable-optimizations --with-ssl --prefix=/usr/local/python3
echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .