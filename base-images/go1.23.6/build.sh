#!/bin/bash
set -eux

GO_FILE="go1.23.6.linux-amd64.tar.gz"
GO_DIR="go"
GO_OUTPUT="go.tgz"
IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-go1.23.6"

# 判断文件不存在才下载
if [ ! -f "$GO_FILE" ]; then
    echo "GO压缩包不存在，开始下载..."
    curl -O https://dl.google.com/go/$GO_FILE
else
    echo "GO压缩包已存在，跳过下载，并清理 $GO_OUTPUT"
    rm -f $GO_OUTPUT
fi

# 解压
tar -xzvf $GO_FILE

# 可安全删除的文件夹
rm -rf $GO_DIR/api
rm -rf $GO_DIR/doc
rm -rf $GO_DIR/misc
rm -rf $GO_DIR/test
rm -f $GO_DIR/codereview.cfg
rm -f $GO_DIR/*.md
rm -f $GO_DIR/PATENTS
rm -f $GO_DIR/VERSION

# 重新打包
tar -czvf $GO_OUTPUT $GO_DIR

# 清理解压的目录
rm -rf $GO_DIR

echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .

echo "清理 $GO_OUTPUT"
rm -f $GO_OUTPUT