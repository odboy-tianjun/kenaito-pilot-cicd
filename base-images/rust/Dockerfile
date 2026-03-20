# 多阶段构建1：安装Rust工具链
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3 AS builder

# 设置环境变量
ENV RUST_HOME=/usr/local/rust
ENV PATH="${RUST_HOME}/bin:${PATH}"
ENV CARGO_HOME=/home/admin/.cargo
ENV RUSTUP_HOME=/home/admin/.rustup
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# 安装编译依赖
RUN set -eux; \
    yum install -y \
        # 编译工具链
        gcc \
        gcc-c++ \
        make \
        cmake \
        # 编译Rust所需的依赖
        openssl-devel \
        libffi-devel \
        zlib-devel \
        # 网络工具
        wget \
        # 系统工具
        procps \
        which \
        && yum clean all \
        && rm -rf /var/cache/yum

# 创建 Rust 用户和目录
RUN set -eux; \
    useradd -m -s /bin/bash rustuser; \
    mkdir -p ${CARGO_HOME} ${RUSTUP_HOME}; \
    chown -R rustuser:rustuser /home/admin /usr/local

# 切换到 rustuser 用户安装 Rust
USER rustuser
WORKDIR /home/admin

# 安装 Rust（使用官方安装脚本）
RUN set -eux; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain stable; \
    # 验证安装
    echo 'export PATH="${CARGO_HOME}/bin:${PATH}"' >> /home/admin/.bashrc

# 配置 Rust 国内镜像源（使用中科大源加速）
RUN set -eux; \
    mkdir -p ${CARGO_HOME}; \
    echo '[source.crates-io]' > ${CARGO_HOME}/config.toml; \
    echo 'replace-with = "ustc"' >> ${CARGO_HOME}/config.toml; \
    echo '' >> ${CARGO_HOME}/config.toml; \
    echo '[source.ustc]' >> ${CARGO_HOME}/config.toml; \
    echo 'registry = "https://mirrors.ustc.edu.cn/crates.io-index"' >> ${CARGO_HOME}/config.toml; \
    echo '' >> ${CARGO_HOME}/config.toml; \
    echo '[net]' >> ${CARGO_HOME}/config.toml; \
    echo 'git-fetch-with-cli = true' >> ${CARGO_HOME}/config.toml; \
    echo '[source.aliyun]' >> ${CARGO_HOME}/config.toml; \
    echo 'registry = "https://mirrors.aliyun.com/crates.io-index"' >> ${CARGO_HOME}/config.toml

# 多阶段构建2：最终镜像
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3

LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="Rust Compilation Environment (stable)"

# 设置环境变量
ENV RUST_HOME=/usr/local/rust
ENV CARGO_HOME=/home/admin/.cargo
ENV RUSTUP_HOME=/home/admin/.rustup
ENV PATH="${CARGO_HOME}/bin:${RUST_HOME}/bin:${PATH}"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# 设置工作目录
WORKDIR /home/admin

# 安装运行时依赖
RUN set -eux; \
    yum install -y \
        # 运行时库
        openssl \
        libffi \
        zlib \
        # 编译工具（用于编译依赖）
        gcc \
        gcc-c++ \
        make \
        cmake \
        # 网络和版本控制
        wget \
        # 调试工具
        procps \
        which \
        strace \
        && yum clean all \
        && rm -rf /var/cache/yum

# 从 builder 阶段复制 Rust 安装
COPY --from=builder --chown=admin:admin /home/admin/.cargo /home/admin/.cargo
COPY --from=builder --chown=admin:admin /home/admin/.rustup /home/admin/.rustup
COPY --from=builder --chown=admin:admin /home/admin/.bashrc /home/admin/.bashrc

# 复制 cargo 配置
COPY --from=builder /home/admin/.cargo/config.toml /home/admin/.cargo/config.toml

# 创建软链接（可选）
RUN ln -sf ${CARGO_HOME}/bin/cargo /usr/local/bin/cargo && \
    ln -sf ${CARGO_HOME}/bin/rustc /usr/local/bin/rustc && \
    ln -sf ${CARGO_HOME}/bin/rustup /usr/local/bin/rustup

# 验证 Rust 安装
RUN set -eux; \
    echo "=== Rust Version ==="; \
    rustc --version; \
    cargo --version; \
    rustup --version; \
    echo "=== Rustup Components ==="; \
    rustup component list; \
    echo "=== Cargo Config ==="; \
    cat ${CARGO_HOME}/config.toml

# 创建一个简单的 Rust 项目测试编译
RUN set -eux; \
    # 创建测试项目
    cargo new hello_world --bin; \
    cd hello_world; \
    # 编译并运行
    cargo build --release; \
    ./target/release/hello_world; \
    # 清理
    cd ..; \
    rm -rf hello_world
