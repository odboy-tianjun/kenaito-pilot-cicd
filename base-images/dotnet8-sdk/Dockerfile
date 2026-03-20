# 基础镜像：已配置TZ和系统工具的Alinux3环境
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3

# 镜像标签信息
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description=".Net SDK 8 (SDK 8.0.403)"

# 设置.Net环境变量
ENV DOTNET_ROOT=/usr/local/dotnet
ENV PATH="${DOTNET_ROOT}:${PATH}"

# 设置工作目录
WORKDIR /home/admin

# 添加.Net压缩包（ADD会自动解压）
ADD dotnet.tgz /usr/local/

# 安装配置JDK
RUN set -eux; \
    # 添加执行权限
    chmod +x ${DOTNET_ROOT}/*; \
    yum install -y \
            libicu \
            openssl-libs \
            krb5-libs \
            zlib \
            libstdc++ \
            && yum clean all \
            && rm -rf /var/cache/yum; \
    # 验证 .NET SDK 安装
        dotnet --info; \
        dotnet --list-sdks; \
        dotnet --list-runtimes
