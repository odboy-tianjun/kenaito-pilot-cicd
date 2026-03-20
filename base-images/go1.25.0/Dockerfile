# 基础镜像：已配置TZ和系统工具的Alinux3环境
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3

# 镜像标签信息
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="Go Development Kit 1.25.0 (go-1.25.0)"

# 设置Go环境变量
## 安装目录(Go标准库、编译器、工具链)
ENV GOROOT=/usr/local/go
## 工作目录(用户自己的代码、第三方包、可执行文件)
ENV GOPATH=/home/admin/go
ENV PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"

# 设置工作目录
WORKDIR /home/admin

# 添加GO压缩包（ADD会自动解压）
ADD go.tgz /usr/local/

# 配置Go环境
RUN set -eux; \
    # 创建Go工作目录
    mkdir -p ${GOPATH}/{src,pkg,bin}; \
    # 验证Go安装
    go version; \
    # 配置Go国内代理（七牛云代理）
    go env -w GO111MODULE=on; \
    go env -w GOPROXY=https://goproxy.cn,direct; \
    go env -w GOPRIVATE=; \
    # 显示Go环境配置确认
    go env | grep -E "GOPROXY|GO111MODULE|GOPATH"

# 验证Go配置
RUN set -eux; \
    echo "=== Go Version ==="; \
    go version; \
    echo "=== Go Environment ==="; \
    go env; \
    echo "=== Go Proxy ==="; \
    go env GOPROXY
