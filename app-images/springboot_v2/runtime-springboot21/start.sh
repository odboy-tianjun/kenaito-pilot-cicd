#!/bin/sh
# ========================================
# Spring Boot 应用启动脚本
# ========================================
set -eux

# ========================================
# 创建应用目录和日志目录
# ========================================
mkdir -p logs
chmod 755 logs

# ========================================
# 验证目录创建成功
# ========================================
ls -al

# ========================================
# 设置 JVM 参数
# ========================================
APP_HOME=/home/admin/${APP_NAME}
echo "$APP_HOME"

SPRING_PROFILE=${ENV_CODE}
echo "$SPRING_PROFILE"

JAVA_OPTS="-server \
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
    -Djava.security.egd=file:/dev/./urandom \
    -Duser.timezone=Asia/Shanghai \
    -Dfile.encoding=UTF-8 \
    -Dspring.profiles.active=${SPRING_PROFILE} \
    -Dserver.port=${SERVER_PORT} \
    -Djava.awt.headless=true"

# ========================================
# 启动应用
# ========================================
exec java ${JAVA_OPTS} -jar ${APP_HOME}/${APP_NAME}.jar
