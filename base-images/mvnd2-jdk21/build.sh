#!/bin/bash
set -eux

MVND_FILE="maven-mvnd-2.0.0-rc-3-linux-amd64.tar.gz"
MVND_DIR="maven-mvnd-2.0.0-rc-3-linux-amd64"
MVND_OUTPUT="mvnd2.tgz"
IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-mvnd2-jdk21"

# 判断文件不存在才下载
if [ ! -f "$MVND_FILE" ]; then
    echo "MVND压缩包不存在，开始下载..."
    # https://mirrors.aliyun.com/apache/maven/mvnd
    curl -O https://mirrors.aliyun.com/apache/maven/mvnd/2.0.0-rc-3/maven-mvnd-2.0.0-rc-3-linux-amd64.tar.gz
else
    echo "MVND压缩包已存在，跳过下载，并清理 $MVND_OUTPUT"
    rm -f $MVND_OUTPUT
fi

# 解压
tar -xzvf $MVND_FILE

# 重命名
mv $MVND_DIR mvnd2

# 替换配置文件
cp -f settings.xml mvnd2/mvn/conf/

# 重新打包
tar -czvf $MVND_OUTPUT mvnd2

# 清理解压的目录
rm -rf mvnd2

echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .

echo "清理 $MVND_OUTPUT"
rm -f $MVND_OUTPUT
