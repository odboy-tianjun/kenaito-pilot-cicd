# Kenaito Pilot CI/CD

## Overview

This project is a CI/CD configuration repository maintained by the Kenaito team, designed for multi-language and multi-platform environments. It provides standardized, scalable build and deployment configurations for development teams, supporting mainstream programming languages and containerized deployment scenarios.

## Project Structure

```
kenaito-pilot-cicd/
├── base-images/          # Docker base images
│   ├── alinux3/         # Alibaba Cloud Linux 3 base image
│   └── java11/          # Java 11 runtime and build tools
├── docker/              # Docker build configurations
│   └── ignore-file/     # .dockerignore templates
│       ├── base/
│       ├── go/
│       ├── java/
│       ├── nodejs/
│       └── python/
├── gitlab/              # Multi-version GitLab CI configurations
│   ├── 1482/
│   │   ├── dotnet/      # .NET 6.0, 8.0, 9.0
│   │   ├── go/          # Go 1.19.4, 1.25.0
│   │   ├── java/        # Java 8, 11, 17, 21 + Maven 3.9.11
│   │   ├── nodejs/      # Node.js 14, 16, 18, 20
│   │   └── python/      # Python 3.9.9, 3.11.13, 3.12.11, 3.13.7
├── jenkins/             # Jenkins CI configurations
└── kubernetes/          # Kubernetes deployment configurations
    ├── ingress-nginx/   # Nginx Ingress Controller (Layer 7 load balancing)
    └── openkruise/      # Kubernetes workload enhancements
```

## Features

### Multi-language Support
- **Java**: Supports JDK 8, 11, 17, 21 with Maven 3.9.11
- **Node.js**: Supports versions 14, 16, 18, 20
- **Python**: Supports versions 3.9.9, 3.11.13, 3.12.11, 3.13.7
- **Go**: Supports versions 1.19.4, 1.25.0
- **.NET**: Supports versions 6.0, 8.0, 9.0

### Containerization Support
- Provides standardized base images based on Alibaba Cloud Linux 3
- Optimized Docker build environments tailored for each language
- Includes .dockerignore templates for each language to optimize build context

### CI/CD Integration
- GitLab CI configuration files supporting parallel builds across multiple versions
- Jenkins configuration templates
- Automated version management and release workflows

### Kubernetes Deployment
- Nginx Ingress Controller configuration (Layer 7 load balancing)
- OpenKruise workload enhancement capabilities
- High-availability deployment suitable for production environments

## Quick Start

### Using Base Images

```bash
# Pull the Java base image
docker pull registry.cn-shanghai.aliyuncs.com/odboy/kenaito-cicd:runtime-jdk11
```

### GitLab CI Configuration

Copy the corresponding language’s `.yml` file into your project’s `.gitlab-ci.yml` to begin usage:

```yaml
include:
  - project: 'odboy-tianjun/kenaito-pilot-cicd'
    file: '/gitlab/1482/java/17-maven3.9.11.yml'
```

## Technology Stack

- **Base OS**: Alibaba Cloud Linux 3
- **Container Platform**: Docker, Kubernetes
- **CI/CD Tools**: GitLab CI, Jenkins
- **Programming Languages**: Java, Node.js, Python, Go, .NET

## Documentation

- [Base Images Guide](./base-images/readme.md)
- [Docker Build Configuration](./docker/ignore-file/readme.md)
- [GitLab CI Configuration](./gitlab/readme.md)
- [Jenkins Configuration](./jenkins/readme.md)
- [Kubernetes Configuration](./kubernetes/readme.md)
- [Ingress Nginx Configuration](./kubernetes/ingress-nginx/readme.md)
- [OpenKruise Configuration](./kubernetes/openkruise/readme.md)

## License

This project is licensed under the terms specified in the LICENSE file.