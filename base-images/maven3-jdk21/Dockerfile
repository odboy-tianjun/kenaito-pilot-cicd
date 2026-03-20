# 基础镜像：已配置TZ和系统工具的Alinux3环境
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-jdk21

# 镜像标签信息
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="Maven3 (maven3.9.14 & jdk21)"

# 设置Maven环境变量
ENV MAVEN_HOME=/usr/local/maven3
ENV MAVEN_CONFIG=/home/admin/.m2
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

# 设置工作目录
WORKDIR /home/admin

# 添加Maven压缩包（ADD会自动解压）
ADD maven3.tgz /usr/local/

# 安装配置Maven
RUN set -eux; \
    # 安装git
    yum install -y git-2.43.7-1.0.1.al8.x86_64; \
    # 创建 Maven 本地仓库目录
    mkdir -p ${MAVEN_CONFIG}; \
    # 添加执行权限
    chmod +x ${MAVEN_HOME}/bin/*; \
    # 验证Maven安装
    mvn -version;
