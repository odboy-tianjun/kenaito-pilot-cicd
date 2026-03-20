#!/bin/bash
set -eux

MAVEN_VERSION="3.9.14"
MAVEN_FILE="apache-maven-$MAVEN_VERSION-bin.tar.gz"
MAVEN_DIR="apache-maven-$MAVEN_VERSION"
MAVEN_OUTPUT="maven3.tgz"
IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-maven3-jdk21"

# 判断文件不存在才下载
if [ ! -f "$MAVEN_FILE" ]; then
    echo "MAVEN压缩包不存在，开始下载..."
    # https://maven.apache.org/download.cgi
    curl -O https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
else
    echo "MAVEN压缩包已存在，跳过下载，并清理 $MAVEN_OUTPUT"
    rm -f $MAVEN_OUTPUT
fi

# 解压
tar -xzvf $MAVEN_FILE

# 重命名
mv $MAVEN_DIR maven3

# 替换配置文件
cp -f settings.xml maven3/conf/

# 重新打包
tar -czvf $MAVEN_OUTPUT maven3

# 清理解压的目录
rm -rf maven3

echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .

echo "清理 $MAVEN_OUTPUT"
rm -f $MAVEN_OUTPUT