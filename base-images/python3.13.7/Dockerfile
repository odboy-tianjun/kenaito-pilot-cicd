# 多阶段构建 - 第一阶段：编译Python
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3 AS builder

# 设置Python环境变量
ENV PYTHON_HOME=/usr/local/python3

# 安装编译依赖
RUN yum install -y \
    libffi-devel \
    zlib-devel \
    bzip2-devel \
    openssl-devel \
    ncurses-devel \
    sqlite-devel \
    readline-devel \
    tk-devel \
    gdbm-devel \
    libpcap-devel \
    xz-devel \
    make \
    gcc \
    sysstat \
    && yum clean all \
    && rm -rf /var/cache/yum

# 添加Python源代码并编译
ADD python3.tgz ./
RUN cd python3 \
    && ./configure --prefix=${PYTHON_HOME} --enable-optimizations \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && rm -rf python3

# 第二阶段：构建最终镜像
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3

# 镜像标签信息
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="Python3 (python-3.10.0)"

# 设置Python环境变量
ENV PYTHON_HOME=/usr/local/python3
ENV PATH="${PYTHON_HOME}/bin:$PATH"

# 从builder阶段复制编译好的Python
COPY --from=builder ${PYTHON_HOME} ${PYTHON_HOME}

# 安装运行时必要的库（比编译时少很多）
RUN yum install -y \
    libffi \
    zlib \
    openssl \
    sqlite \
    readline \
    tk \
    gdbm \
    xz \
    && yum clean all \
    && rm -rf /var/cache/yum

# 配置pip镜像源
COPY pip.conf ~/.pip/

# 验证安装
RUN python3 -V \
    && pip3 -V

# 设置工作目录
WORKDIR /home/admin