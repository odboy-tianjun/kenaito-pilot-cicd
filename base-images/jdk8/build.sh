#!/bin/bash
set -eux

JDK_FILE="Alibaba_Dragonwell_Standard_8.25.24_x64_linux.tar.gz"
JDK_DIR="dragonwell-8.25.24"
JDK_OUTPUT="java.tgz"
IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-jdk8"

# 判断文件不存在才下载
if [ ! -f "$JDK_FILE" ]; then
    echo "JDK压缩包不存在，开始下载..."
    curl -O https://dragonwell.oss-cn-shanghai.aliyuncs.com/8.25.24/$JDK_FILE
else
    echo "JDK压缩包已存在，跳过下载，并清理 $JDK_OUTPUT"
    rm -f $JDK_OUTPUT
fi

# 解压
tar -xzvf $JDK_FILE

# 可安全删除的文件夹
rm -rf $JDK_DIR/sample
rm -f $JDK_DIR/src.zip

# 重命名
mv $JDK_DIR java

# 重新打包
tar -czvf $JDK_OUTPUT java

# 清理解压的目录
rm -rf java

echo "JDK重新打包完成: $JDK_OUTPUT"

echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .