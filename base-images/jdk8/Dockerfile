# 基础镜像：已配置TZ和系统工具的Alinux3环境
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3

# 镜像标签信息
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="Java Development Kit 8 (dragonwell-8.25.24)"

# 设置Java环境变量
ENV JAVA_HOME=/usr/local/java
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# 设置工作目录
WORKDIR /home/admin

# 添加JDK压缩包（ADD会自动解压）
ADD java.tgz /usr/local/

# 安装配置JDK
RUN set -eux; \
    # 添加执行权限
    chmod +x ${JAVA_HOME}/bin/*; \
    # 验证JDK安装
    java -version;

# 容器启动默认进入bash，会继承父镜像的指令
# CMD ["/bin/bash"]
