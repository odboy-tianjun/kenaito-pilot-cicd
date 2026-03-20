# 基础镜像：已配置TZ和系统工具的Alinux3环境
#FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:system-alinux3
FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-python3.10.0

# 镜像标签信息
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="Node.js 24.14.0 (nodejs-24.14.0)"

# 设置Node.js环境变量
ENV NODE_HOME=/usr/local/nodejs
ENV PATH="${NODE_HOME}/bin:${PATH}"

# 设置工作目录
WORKDIR /home/admin

# 添加Node.js压缩包（ADD会自动解压）
ADD nodejs.tgz /usr/local/

# 配置Node.js环境和加速源
RUN set -eux; \
    npm install yarn pnpm -g; \
    # 配置 npm 淘宝镜像源
    npm config set registry https://registry.npmmirror.com; \
    # 配置 npm 缓存路径
    npm config set cache /home/admin/.npm --global; \
    # 配置 yarn 淘宝镜像源
    yarn config set registry https://registry.npmmirror.com; \
    # 配置 pnpm 淘宝镜像源
    pnpm config set registry https://registry.npmmirror.com

# 验证最终配置
RUN set -eux; \
    echo "========== Node.js Environment =========="; \
    node -v; \
    npm -v; \
    npx -v; \
    yarn -v; \
    pnpm -v; \
    \
    echo "\n========== Npm Configuration =========="; \
    npm config get registry; \
    npm config get cache; \
    npm config get prefix; \
    npm config list --json | head -20; \
    \
    echo "\n========== Yarn Configuration =========="; \
    yarn config get registry; \
    yarn config list --json; \
    \
    echo "\n========== PNpm Configuration =========="; \
    pnpm config get registry; \
    pnpm config get store-dir; \
    pnpm config get global-dir; \
    pnpm config get cache-dir; \
    pnpm config list
