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
    -XX:+OptimizeStringConcat \
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
    --add-opens java.base/java.lang=ALL-UNNAMED \
    --add-opens java.base/java.io=ALL-UNNAMED \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.util.concurrent=ALL-UNNAMED \
    --add-opens java.base/java.net=ALL-UNNAMED \
    --add-opens java.base/sun.net.www.protocol.https=ALL-UNNAMED \
    --add-opens java.base/sun.net.www=ALL-UNNAMED"

# ========================================
# 启动应用前，判断应用是否正在运行，如果是则执行kill -15 等待直到应用结束运行
# ========================================
# 查找Java进程（排除当前脚本和grep进程）
APP_PID=$(pgrep -f "${APP_NAME}.jar" | grep -v $$ | head -1 || true)
if [ -n "$APP_PID" ]; then
    echo "Application is already running with PID: $APP_PID, stopping it..."
    kill -15 "$APP_PID"
    # 等待进程结束，最多等待30秒
    for i in $(seq 1 30); do
        sleep 1
        # 使用ps检查进程是否还存在
        CHECK_PID=$(ps -ef | grep -v grep | grep "${APP_NAME}.jar" | awk '{print $2}' | head -1)
        if [ -z "$CHECK_PID" ]; then
            echo "Application stopped successfully"
            break
        fi
        echo "Waiting for application to stop... ($i/30)"
    done
    # 如果进程还在，强制kill
    CHECK_PID=$(pgrep -f "${APP_NAME}.jar" | grep -v $$ | head -1 || true)
    if [ -n "$CHECK_PID" ]; then
        echo "Application did not stop gracefully, forcing kill..."
        kill -9 "$CHECK_PID" 2>/dev/null || true
    fi
fi

# ========================================
# 启动应用
# ========================================
java ${JAVA_OPTS} -jar ${APP_HOME}/${APP_NAME}.jar &

# 获取Java进程PID
JAVA_PID=$!
echo "Java application started with PID: $JAVA_PID"
