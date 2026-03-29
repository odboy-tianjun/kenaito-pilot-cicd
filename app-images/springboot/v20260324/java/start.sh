#!/bin/sh
# ========================================
# Spring Boot 应用启动脚本
# ========================================
set -eux

# ========================================
# 创建应用目录和日志目录
# ========================================
if [ ! -d "logs" ]; then
    mkdir -p logs
    chmod 755 logs
fi


# ========================================
# 验证目录创建成功
# ========================================
ls -al

# ========================================
# 设置 JVM 参数
# ========================================
APP_HOME=/home/admin/${APP_NAME}
SPRING_PROFILE=${ENV_CODE}
echo "JAVA_VERSION: ${JAVA_VERSION}"
JAVA_OPTS="-server \
    -XX:+UseContainerSupport \
    -XX:InitialRAMPercentage=75.0 \
    -XX:MaxRAMPercentage=75.0 \
    -XX:+UseG1GC \
    -XX:MaxGCPauseMillis=200 \
    -XX:+ParallelRefProcEnabled \
    -XX:InitiatingHeapOccupancyPercent=35 \
    -XX:G1ReservePercent=15 \
    -XX:+UseStringDeduplication \
    -XX:+HeapDumpOnOutOfMemoryError \
    -XX:HeapDumpPath=${APP_HOME}/logs/java.hprof \
    -XX:ErrorFile=${APP_HOME}/logs/hs_err_pid%p.log \
    -Dlogging.file.path=${APP_HOME}/logs \
    -Dlogging.file.name=${APP_HOME}/logs/java.log \
    -Djava.security.egd=file:/dev/./urandom \
    -Duser.timezone=Asia/Shanghai \
    -Dfile.encoding=UTF-8 \
    -Dspring.profiles.active=${SPRING_PROFILE} \
    -Dserver.port=${SERVER_PORT} \
    -Djava.awt.headless=true \
    --add-modules java.xml.bind \
    --add-opens java.base/java.lang=ALL-UNNAMED \
    --add-opens java.base/java.io=ALL-UNNAMED \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.util.concurrent=ALL-UNNAMED \
    --add-opens java.base/java.net=ALL-UNNAMED \
    --add-opens java.base/sun.net.www.protocol.https=ALL-UNNAMED \
    --add-opens java.base/sun.net.www=ALL-UNNAMED \
    --add-opens java.base/sun.nio.ch=ALL-UNNAMED \
    --add-opens java.base/sun.security.util=ALL-UNNAMED \
    --add-opens java.base/sun.security.x509=ALL-UNNAMED"

sh stop.sh

# ========================================
# 启动应用
# ========================================
java ${JAVA_OPTS} -jar ${APP_HOME}/${APP_NAME}.jar &

# 获取Java进程PID
JAVA_PID=$!
echo "Java application started with PID: $JAVA_PID"
