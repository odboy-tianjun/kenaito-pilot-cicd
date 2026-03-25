# 基础镜像：已配置TZ和系统工具的Alinux3环境
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3

# 镜像标签信息
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="Java Development Kit All (dragonwell8 & openjdk-11、17、21)"

# 设置Java环境变量
ENV JAVA_HOME=/usr/local/java
ENV PATH="${JAVA_HOME}/bin:${PATH}"
ENV JAVA_VERSION=8

# 设置工作目录
WORKDIR /home/admin

# 添加JDK压缩包（ADD会自动解压）
ADD java8.tgz /usr/local/
ADD java11.tgz /usr/local/
ADD java17.tgz /usr/local/
ADD java21.tgz /usr/local/

# 安装配置JDK
RUN set -eux; \
    # 创建软连接 \
    ln -s /usr/local/java8 /usr/local/java; \
    # 添加执行权限
    chmod +x /usr/local/java8/bin/*; \
    chmod +x /usr/local/java11/bin/*; \
    chmod +x /usr/local/java17/bin/*; \
    chmod +x /usr/local/java21/bin/*; \
    # 验证JDK安装
    java -version;

