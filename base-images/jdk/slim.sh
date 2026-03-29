#!/bin/bash
set -eux

# 有问题，不推荐使用
# https://github.com/slimtoolkit/slim/releases
# slim 1.40.11
# docker-client 1.54
#docker-slim --version
#slim --version
#mint --version
#mint-sensor --version

slim --crt-api-version=1.54 build \
--target registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-jdk \
--tag registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-jdk-slim \
--http-probe=false \
--include-path=/etc \
--include-path=/usr/ \
--include-path=/sbin/ \
--include-path=/root/ \
--include-path=/bin/ \
--include-bin=/bin/bash \
--include-path=/usr/local/java/ \
--include-path=/home/admin/ \
--exec "curl checkip.amazonaws.com"