# 基础镜像：已配置TZ和系统工具的Alinux3环境
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3

# 镜像标签信息
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="C/C++ Development Environment (gcc, make, cmake, etc.)"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# 设置工作目录
WORKDIR /home/admin

# 安装完整的C编译工具链和常用库
RUN set -eux; \
    yum install -y \
        # 基础编译工具
        gcc \
        gcc-c++ \
        make \
        cmake \
        autoconf \
        automake \
        libtool \
        patch \
        # 调试和分析工具
        gdb \
        strace \
        valgrind \
        ltrace \
        # 文档工具
        man \
        man-pages \
        # 压缩和归档工具
        tar \
        gzip \
        bzip2 \
        xz \
        zip \
        unzip \
        # 网络工具
        curl \
        wget \
        net-tools \
        # 系统工具
        procps \
        which \
        file \
        # 常用开发库（静态和动态）
        glibc-static \
        glibc-devel \
        libstdc++-static \
        libstdc++-devel \
        # 常用基础库（包含之前缺失的libatomic）
        libatomic \
        libatomic-static \
        libffi-devel \
        zlib-devel \
        bzip2-devel \
        openssl-devel \
        ncurses-devel \
        readline-devel \
        sqlite-devel \
        libpcap-devel \
        libxml2-devel \
        libxslt-devel \
        # 数学库
        lapack-devel \
        openblas-devel \
        # 其他工具
        vim-minimal \
        tree \
        && yum clean all \
        && rm -rf /var/cache/yum

# 验证编译环境
RUN set -eux; \
    echo "=== GCC Version ==="; \
    gcc --version | head -n1; \
    g++ --version | head -n1; \
    echo "=== Make Version ==="; \
    make --version | head -n1; \
    echo "=== CMake Version ==="; \
    cmake --version | head -n1; \
    echo "=== GDB Version ==="; \
    gdb --version | head -n1; \
    echo "=== libatomic check ==="; \
    ldconfig -p | grep libatomic || true; \
    echo "=== Environment is ready ==="

# 创建一个简单的C程序测试编译
RUN set -eux; \
    echo '#include <stdio.h>' > /tmp/test.c; \
    echo 'int main() { printf("C compiler works!\\n"); return 0; }' >> /tmp/test.c; \
    gcc -o /tmp/test /tmp/test.c; \
    /tmp/test; \
    rm -f /tmp/test /tmp/test.c

# 创建一个简单的C++程序测试编译
RUN set -eux; \
    echo '#include <iostream>' > /tmp/test.cpp; \
    echo 'int main() { std::cout << "C++ compiler works!" << std::endl; return 0; }' >> /tmp/test.cpp; \
    g++ -o /tmp/test /tmp/test.cpp; \
    /tmp/test; \
    rm -f /tmp/test /tmp/test.cpp
