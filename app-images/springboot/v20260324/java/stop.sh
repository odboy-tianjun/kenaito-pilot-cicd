#!/bin/sh
# ========================================
# Spring Boot 应用停止脚本
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
