FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-jdk21

# ========================================
# 镜像元数据
# ========================================
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
      description="Spring Boot Application Runtime Image" \
      java.version="21"

# ========================================
# 构建参数（可在 docker build 时通过 --build-arg 传入）
# ========================================
ARG APP_NAME="default"
ARG ENV_CODE="default"

# ========================================
# 环境变量配置
# ========================================
# 应用部署目录
ENV APP_HOME=/home/admin/${APP_NAME}
# 环境标识（用于激活对应的 Spring Profile）
ENV SPRING_PROFILE=${ENV_CODE}
# 时区设置
ENV TZ=Asia/Shanghai
# 应用端口
ENV SERVER_PORT=8001
# JVM 启动参数
ENV JAVA_OPTS="-server \
    -XX:+UseContainerSupport \
    -XX:InitialRAMPercentage=90.0 \
    -XX:MaxRAMPercentage=90.0 \
    -XX:+UseG1GC \
    -XX:MaxGCPauseMillis=200 \
    -XX:+ParallelRefProcEnabled \
    -XX:InitiatingHeapOccupancyPercent=70 \
    -XX:G1ReservePercent=10 \
    -XX:+HeapDumpOnOutOfMemoryError \
    -XX:HeapDumpPath=${APP_HOME}/logs/heapdump.hprof \
    -XX:ErrorFile=${APP_HOME}/logs/hs_err_pid%p.log \
    -XX:OnOutOfMemoryError='kill -9 %p' \
    -Djava.security.egd=file:/dev/./urandom \
    -Duser.timezone=Asia/Shanghai \
    -Dfile.encoding=UTF-8 \
    -Dspring.profiles.active=${SPRING_PROFILE} \
    -Dserver.port=${SERVER_PORT} \
    -Djava.awt.headless=true"

# ========================================
# 创建应用目录和日志目录
# ========================================
RUN set -eux; \
    # 创建应用目录
    mkdir -p ${APP_HOME}; \
    # 创建日志目录
    mkdir -p ${APP_HOME}/logs; \
    # 设置日志目录可写权限
    chmod 755 ${APP_HOME}/logs; \
    # 验证目录创建成功
    ls -ld ${APP_HOME} ${APP_HOME}/logs;

# ========================================
# 暴露应用端口
# ========================================
EXPOSE ${SERVER_PORT}

# ========================================
# 工作目录
# ========================================
WORKDIR ${APP_HOME}

# ========================================
# 应用启动入口
# ========================================
ENTRYPOINT ["java ${JAVA_OPTS} -jar *.jar"]
