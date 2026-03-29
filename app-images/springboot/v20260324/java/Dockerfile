FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-jdk

# ========================================
# 镜像元数据
# ========================================
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0.20260324" \
      description="Spring Boot Application Runtime Image"

# ========================================
# 环境变量配置
# ========================================
# 时区设置
ENV TZ=Asia/Shanghai
# 应用端口
ENV SERVER_PORT=8000

# ========================================
# 暴露应用端口
# ========================================
EXPOSE ${SERVER_PORT}

# ========================================
# 复制启动脚本
# ========================================
COPY start.sh /usr/local/start.sh
COPY stop.sh /usr/local/stop.sh
RUN chmod +x /usr/local/start.sh && chmod +x /usr/local/stop.sh

# ========================================
# 应用启动入口
# ========================================
#这里注释掉，是因为在start.sh脚本中明确了jar所在的位置
#ENTRYPOINT ["sh", "-c", "cp -f /usr/local/start.sh . && ./start.sh"]
ENTRYPOINT ["sh", "-c", "/home/admin/start.sh; while true; do sleep 30d; done"]
