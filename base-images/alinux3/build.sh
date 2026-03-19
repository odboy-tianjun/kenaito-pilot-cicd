#!/bin/bash
set -eux

echo "开始构建镜像"
docker build -t registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3 .