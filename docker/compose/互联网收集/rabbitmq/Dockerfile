#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

# The official Canonical Ubuntu Focal image is ideal from a security perspective,
# especially for the enterprises that we, the RabbitMQ team, have to deal with
FROM rabbitmq:4.0

LABEL maintainer="kennylee <kennylee26@gmail.com>"

RUN sed -i 's|http://.*archive.ubuntu.com|http://mirrors.aliyun.com|g' /etc/apt/sources.list.d/ubuntu.sources && \
     sed -i 's|http://.*security.ubuntu.com|http://mirrors.aliyun.com|g' /etc/apt/sources.list.d/ubuntu.sources && \
     sed -i 's|http://ports.ubuntu.com|http://mirrors.aliyun.com|g' /etc/apt/sources.list.d/ubuntu.sources

# Set environment variables.
ENV LANG="zh_CN.UTF-8" \
    LANGUAGE="zh_CN:zh:en_US:en" \
    LC_ALL="zh_CN.UTF-8" \
    TZ="Asia/Shanghai" \
    DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm"

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade &&  \
  apt-get install -y curl unzip vim gnupg wget iputils-ping && \
  apt-get install -y language-pack-zh-hans && \
  apt-get install -y dialog apt-utils tzdata && \
  rm -rf /var/lib/apt/lists/*

RUN locale

RUN echo $TZ  > /etc/timezone && \
        dpkg-reconfigure --frontend noninteractive tzdata