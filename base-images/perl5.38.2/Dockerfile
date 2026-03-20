# 多阶段构建1：编译Perl
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3 AS builder

# 设置环境变量
ENV PERL_HOME=/usr/local/perl
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# 安装编译依赖
RUN set -eux; \
    yum install -y \
        # 编译工具
        gcc \
        make \
        # 必要的开发库
        zlib-devel \
        openssl-devel \
        expat-devel \
        gdbm-devel \
        libdb-devel \
        # 工具
        wget \
        tar \
        && yum clean all \
        && rm -rf /var/cache/yum

# 下载并编译 Perl（使用最新稳定版 5.38.2）
RUN set -eux; \
    wget https://www.cpan.org/src/5.0/perl-5.38.2.tar.gz; \
    tar -xzf perl-5.38.2.tar.gz; \
    cd perl-5.38.2; \
    ./Configure -des \
        -Dprefix=${PERL_HOME} \
        -Dusethreads \
        -Duseshrplib \
        -Duse64bitall \
        -Duselargefiles; \
    make -j$(nproc); \
    make install; \
    cd ..; \
    rm -rf perl-5.38.2 perl-5.38.2.tar.gz

# 多阶段构建2：最终镜像（仅包含编译好的Perl和必要工具）
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3

# 镜像标签信息
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="Perl Compilation Environment (perl-5.38.2)"

# 设置环境变量
ENV PERL_HOME=/usr/local/perl
ENV PATH="${PERL_HOME}/bin:${PATH}"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PERL_CPANM_HOME=/home/admin/.cpanm

# 设置工作目录
WORKDIR /home/admin

# 从builder阶段复制编译好的Perl
COPY --from=builder ${PERL_HOME} ${PERL_HOME}

# 安装运行时依赖和常用Perl工具
RUN set -eux; \
    yum install -y \
        # 运行时库
        zlib \
        openssl \
        expat \
        gdbm \
        libdb \
        wget \
        make \
        gcc \
        # 调试工具
        procps \
        which \
        && yum clean all \
        && rm -rf /var/cache/yum

# 配置 CPAN 镜像源
RUN set -eux; \
    # 创建 CPAN 配置目录
    mkdir -p /home/admin/.cpan/CPAN; \
    # 写入镜像源配置
    echo 'o conf urllist push https://mirrors.aliyun.com/CPAN/' > /home/admin/.cpan/CPAN/MyConfig.pm; \
    echo 'o conf urllist push https://mirrors.tuna.tsinghua.edu.cn/CPAN/' >> /home/admin/.cpan/CPAN/MyConfig.pm; \
    echo 'o conf commit' >> /home/admin/.cpan/CPAN/MyConfig.pm; \
    # 确保权限正确
    chmod -R 755 /home/admin/.cpan

# 安装 cpanm（更方便的模块安装工具）
RUN set -eux; \
    curl -L https://cpanmin.us -o /usr/local/bin/cpanm; \
    chmod +x /usr/local/bin/cpanm; \
    # 配置 cpanm 使用镜像源
    echo 'alias cpanm="cpanm --mirror https://mirrors.aliyun.com/CPAN/ --mirror-only"' >> /home/admin/.bashrc

# 验证Perl安装
RUN set -eux; \
    echo "=== Perl Version ==="; \
    perl -v | head -5; \
    echo "=== Perl Modules Path ==="; \
    perl -e 'print join("\n", @INC);'; \
    echo "=== cpanm Version ==="; \
    cpanm --version | head -n1

# 创建一个测试脚本验证编译环境
RUN set -eux; \
    # 使用 env 方式指定 perl 解释器
    echo '#!/usr/bin/env perl' > /tmp/test.pl; \
    echo 'use strict;' >> /tmp/test.pl; \
    echo 'use warnings;' >> /tmp/test.pl; \
    echo 'print "Perl compiler works!\\n";' >> /tmp/test.pl; \
    echo 'my $sum = 0;' >> /tmp/test.pl; \
    echo '$sum += $_ for (1..10);' >> /tmp/test.pl; \
    echo 'print "Sum of 1..10 = $sum\\n";' >> /tmp/test.pl; \
    chmod +x /tmp/test.pl; \
    # 执行测试
    /tmp/test.pl; \
    # 清理
    rm -f /tmp/test.pl
