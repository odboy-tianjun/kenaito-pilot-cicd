#!/bin/bash
set -eux

NODEJS_FILE="node-v14.21.3-linux-x64.tar.gz"
NODEJS_DIR="node-v14.21.3-linux-x64"
NODEJS_OUTPUT="nodejs.tgz"
IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-nodejs14.21.3"

# 判断文件不存在才下载
if [ ! -f "$NODEJS_FILE" ]; then
    echo "NODEJS压缩包不存在，开始下载..."
    curl -O https://nodejs.org/dist/v14.21.3/$NODEJS_FILE
else
    echo "NODEJS压缩包已存在，跳过下载，并清理 $NODEJS_OUTPUT"
    rm -f $NODEJS_OUTPUT
fi

# 解压
tar -xzvf $NODEJS_FILE

# 可安全删除的文件夹
rm -rf $NODEJS_DIR/share

# 重命名
mv $NODEJS_DIR nodejs

# 重新打包
tar -czvf $NODEJS_OUTPUT nodejs

# 清理解压的目录
rm -rf nodejs

echo "NODEJS重新打包完成: $NODEJS_OUTPUT"

echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .