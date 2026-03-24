#!/bin/bash
set -eux

JDK_FILE="openjdk-17.0.2_linux-x64_bin.tar.gz"
JDK_DIR="jdk-17.0.2"
JDK_OUTPUT="java17.tgz"

# 判断文件不存在才下载
if [ ! -f "$JDK_FILE" ]; then
    echo "JDK压缩包不存在，开始下载..."
    curl -O https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/$JDK_FILE
else
    echo "JDK压缩包已存在，跳过下载，并清理 $JDK_OUTPUT"
    rm -f $JDK_OUTPUT
fi

# 解压
tar -xzvf $JDK_FILE

# 删除无用的src.zip
rm -f $JDK_DIR/lib/src.zip

# 重命名
mv $JDK_DIR java17

# 重新打包
tar -czvf $JDK_OUTPUT java17

# 清理解压的目录
rm -rf java17

echo "JDK重新打包完成: $JDK_OUTPUT"
