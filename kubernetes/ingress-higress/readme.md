# 云原生API网关（未测试）

> 官方文档 https://higress.cn/docs/latest/user/quickstart/

# 开源地址

https://github.com/alibaba/higress

# 安装步骤

## 一、前置条件

- 已安装 Helm 3
- 集群有 MetalLB（或其他可用的 LoadBalancer）
- 网络插件正常（Calico/Flannel 等）

## 二、Helm安装

```shell
helm repo add higress.io https://higress.io/helm-charts
helm install higress -n higress-system higress.io/higress --create-namespace --render-subchart-notes --set global.local=true --set global.o11y.enabled=false

# 获取 Higress Gateway 的 LoadBalancer IP，并记录下来。后续可以通过该 IP 的 80 和 443 端口访问 Higress Gateway
kubectl get svc -n higress-system higress-gateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
```