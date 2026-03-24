FROM registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-jdk

# ========================================
# 镜像元数据
# ========================================
LABEL maintainer="tianjun@odboy.cn" \
      version="1.0" \
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
RUN chmod +x /usr/local/start.sh

# ========================================
# 应用启动入口
# ========================================
ENTRYPOINT ["sh", "-c", "cp -f /usr/local/start.sh . && ./start.sh && sleep 365d"]
