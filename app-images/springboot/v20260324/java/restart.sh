#!/bin/sh
# ========================================
# Spring Boot 应用重启脚本
# ========================================
set -eux

# ========================================
# 设置 JVM 参数（根据JDK版本动态调整）
# ========================================
APP_HOME=/home/admin/${APP_NAME}
SPRING_PROFILE=${ENV_CODE}

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
# 判断当前Java版本并切换软链接
# ========================================
# 清理 JAVA_VERSION 变量（去除前后空格和Windows换行符\r）
JAVA_VERSION=$(echo "${JAVA_VERSION}" | tr -d '\r' | tr -d ' ')
echo "JAVA_VERSION: ${JAVA_VERSION}"
case "${JAVA_VERSION}" in
8)
  # n特指目录
	ln -sfn /usr/local/java8 /usr/local/java
	;;
11)
	ln -sfn /usr/local/java11 /usr/local/java
	;;
17)
	ln -sfn /usr/local/java17 /usr/local/java
	;;
21)
	ln -sfn /usr/local/java21 /usr/local/java
	;;
*)
	echo "Warning: Unknown JAVA_VERSION=${JAVA_VERSION}, using default java8"
	;;
esac

# 验证Java版本
echo "Current Java: $(/usr/local/java/bin/java -version 2>&1 | head -1)"

# 通用JVM参数（所有版本适用）
JAVA_OPTS="-server \
    -XX:+UseContainerSupport \
    -XX:InitialRAMPercentage=85.0 \
    -XX:MaxRAMPercentage=85.0 \
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
    -Djava.awt.headless=true"

# 根据JDK版本添加特定参数
case "${JAVA_VERSION}" in
8)
	# JDK 8: 不需要--add-modules和--add-opens
	echo "Using JDK 8 specific configuration"
	;;
11)
	# JDK 11: 需要add-modules java.xml.bind，但不需要虚拟线程参数
	echo "Using JDK 11 specific configuration"
	JAVA_OPTS="${JAVA_OPTS} \
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
	;;
17)
	# JDK 17: 不需要--add-modules java.xml.bind，需要--add-opens
	echo "Using JDK 17 specific configuration"
	JAVA_OPTS="${JAVA_OPTS} \
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
	;;
21)
	# JDK 21: 同JDK 17，并可选启用虚拟线程调度器参数
	echo "Using JDK 21 specific configuration with virtual threads"
	JAVA_OPTS="${JAVA_OPTS} \
    --add-opens java.base/java.lang=ALL-UNNAMED \
    --add-opens java.base/java.io=ALL-UNNAMED \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.util.concurrent=ALL-UNNAMED \
    --add-opens java.base/java.net=ALL-UNNAMED \
    --add-opens java.base/sun.net.www.protocol.https=ALL-UNNAMED \
    --add-opens java.base/sun.net.www=ALL-UNNAMED \
    --add-opens java.base/sun.nio.ch=ALL-UNNAMED \
    --add-opens java.base/sun.security.util=ALL-UNNAMED \
    --add-opens java.base/sun.security.x509=ALL-UNNAMED \
    -Djdk.virtualThreadScheduler.parallelism=4 \
    -Djdk.virtualThreadScheduler.maxPoolSize=256"
	;;
*)
	echo "Warning: Unknown JAVA_VERSION=${JAVA_VERSION}, using JDK 8 configuration"
	;;
esac

sh stop.sh

# ========================================
# 启动应用
# ========================================
java ${JAVA_OPTS} -jar ${APP_HOME}/${APP_NAME}.jar &

# 获取Java进程PID
JAVA_PID=$!
echo "Java application started with PID: $JAVA_PID"
