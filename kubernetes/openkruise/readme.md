# Kubernetes 的扩展套件，主要聚焦于云原生应用的自动化，比如部署、发布、运维以及可用性防护

> 官方文档 https://openkruise.io/zh/docs/installation

# 开源地址

https://github.com/openkruise/kruise

# 版本选择

![version](./202604180852.png)

# chart包选择

- kruise-{version}.tgz dockerhub版
- kruise-{version}.cn.tgz 国内版

# 安装脚本

```shell
# 安装
helm install kruise /root/kruise-1.4.2.cn.tgz

# 升级
helm upgrade kruise /root/kruise-1.5.5.cn.tgz
```
