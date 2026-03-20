FROM alibaba-cloud-linux-3-registry.cn-hangzhou.cr.aliyuncs.com/alinux3/alinux3:latest

LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="基础Alinux3镜像，配置时区并安装常用工具"

# 这种写法存在问题
#ENV TZ=Asia/Shanghai \
#    LANG=en_US.UTF-8 \
#    LC_ALL=en_US.UTF-8

# 推荐写法
ENV TZ=Asia/Shanghai
## 可选：C.UTF-8、en_US.UTF-8、zh_CN.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /home/admin

RUN set -eux; \
    # 配置时区
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone; \
    # 更换镜像源为阿里云公共镜像源
    sed -i 's/mirrors.cloud.aliyuncs.com/mirrors.aliyun.com/g' /etc/yum.repos.d/*.repo; \
    # 安装常用工具
    yum install -y tar net-tools bind-utils; \
    # 清理yum缓存，减小镜像体积
    yum clean all; \
    rm -rf /var/cache/yum/*

CMD ["/bin/bash"]