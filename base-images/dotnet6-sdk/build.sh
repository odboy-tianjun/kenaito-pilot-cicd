#!/bin/bash
set -eux

DOTNET_FILE="dotnet-sdk-6.0.427-linux-x64.tar.gz"
DOTNET_DIR="dotnet-sdk-6.0.427-linux-x64"
DOTNET_OUTPUT="dotnet.tgz"
IMAGE_NAME="registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-dotnet6-sdk"
# 下载太慢了，手动下载吧兄弟们
DOTNET_URL="https://builds.dotnet.microsoft.com/dotnet/Sdk/6.0.427/dotnet-sdk-6.0.427-linux-x64.tar.gz"

if [ ! -f "$DOTNET_FILE" ]; then
    echo "DOTNET压缩包不存在，请先手动下载后，放置到当前文件夹内..."
    return
else
    echo "DOTNET压缩包已存在，跳过下载，并清理 $DOTNET_OUTPUT"
    rm -f $DOTNET_OUTPUT
fi

# 解压
mkdir $DOTNET_DIR
tar -xzvf $DOTNET_FILE -C $DOTNET_DIR

# 可安全删除的文件夹
rm -rf $DOTNET_DIR/sdk-manifests
rm -rf $DOTNET_DIR/templates
rm -rf $DOTNET_DIR/packs


# 重命名
mv $DOTNET_DIR dotnet

# 重新打包
tar -czvf $DOTNET_OUTPUT dotnet

# 清理解压的目录
rm -rf dotnet

echo "DOTNET重新打包完成: $DOTNET_OUTPUT"

echo "开始构建镜像: $IMAGE_NAME"
docker build --progress=plain --no-cache -t $IMAGE_NAME .

echo "清理 $DOTNET_OUTPUT"
rm -f $DOTNET_OUTPUT