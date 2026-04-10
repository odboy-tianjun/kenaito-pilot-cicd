# Kenaito Pilot CI/CD

## 概述

本项目是一个面向多语言、多平台的持续集成与持续部署（CI/CD）配置仓库，由 Kenaito 团队维护。

项目旨在为开发团队提供标准化、可扩展的构建和部署配置，支持主流编程语言和容器化部署场景。

## 项目结构

```
kenaito-pilot-cicd/
├── base-images/         # Docker 基础镜像
│   ├── alinux3/         # Alibaba Cloud Linux 3 基础镜像
│   └── java11/          # Java 11 运行环境和构建工具
├── docker/              # Docker 构建配置
│   └── ignore-file/     # .dockerignore 模板
│       ├── base/
│       ├── go/
│       ├── java/
│       ├── nodejs/
│       └── python/
├── gitlab-ci/           # GitLab CI 多语言配置
├── gitlab-runner/       # GitLab Runner 配置
├── jenkins/             # Jenkins CI 配置
└── kubernetes/          # Kubernetes 部署配置
    ├── ingress-nginx/   # Nginx 入口控制器（7层负载均衡）
    ├── openkruise/      # Kubernetes 工作负载增强
    └── workload/        # Kubernetes 工作负载配置，例如：Deployment、StatefulSet
```

## 功能特性

### 多语言支持

- **Java**: 支持 JDK 8, 11, 17, 21 版本，配合 Maven 3.9.11
- **Node.js**: 支持 14, 16, 18, 20 版本
- **Python**: 支持 3.9.9, 3.11.13, 3.12.11, 3.13.7 版本
- **Go**: 支持 1.19.4, 1.25.0 版本
- **.NET**: 支持 6.0, 8.0, 9.0 版本

### 容器化支持

- 提供基于 Alibaba Cloud Linux 3 的标准化基础镜像
- 针对不同语言提供优化的 Docker 构建环境
- 包含各语言的 .dockerignore 模板，优化构建上下文

### CI/CD 集成

- GitLab CI 配置文件，支持多版本并行构建
- Jenkins 配置模板
- 自动化版本管理和发布流程

### Kubernetes 部署

- Nginx Ingress Controller 配置（7层负载均衡）
- OpenKruise 工作负载增强能力
- 适用于生产环境的高可用部署

## 快速开始

### 使用基础镜像

```bash
# 使用 Java 基础镜像
docker pull registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-jdk11
```

### GitLab CI 配置

将对应语言的 `.yml` 文件复制到项目的 `.gitlab-ci.yml` 即可开始使用：

```yaml
include:
  - project: 'odboy-tianjun/kenaito-pilot-cicd'
    file: '/gitlab/1482/java/17-maven3.9.11.yml'
```

## 技术栈

- **基础系统**: Alibaba Cloud Linux 3
- **容器平台**: Docker, Kubernetes
- **CI/CD 工具**: GitLab CI, Jenkins
- **编程语言**: Java, Node.js, Python, Go, .NET

## 文档

- [基础镜像说明](./base-images/readme.md)
- [Docker 构建配置](./docker/ignore-file/readme.md)
- [GitLab CI 配置](./gitlab/readme.md)
- [Jenkins 配置](./jenkins/readme.md)
- [Kubernetes 配置](./kubernetes/readme.md)
- [Ingress Nginx 配置](./kubernetes/ingress-nginx/readme.md)
- [OpenKruise 配置](./kubernetes/openkruise/readme.md)

## 许可证

本项目遵循 LICENSE 文件中指定的许可证。