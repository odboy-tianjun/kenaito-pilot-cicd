# 现代化的 HTTP 反向代理和负载均衡器

> 官方文档 https://doc.traefik.io/traefik/getting-started/kubernetes/#install-traefik

# 开源地址

https://github.com/traefik/traefik
https://github.com/traefik/traefik-helm-chart

# 安装步骤

## 一、前置条件

- K8s ≥ 1.20（推荐 1.24+）
- 已安装 Helm 3
- 集群有 MetalLB（或其他可用的 LoadBalancer）
- 网络插件正常（Calico/Flannel 等）

## 二、执行脚本

```shell
#git clone https://github.com/traefik/traefik-helm-chart.git
#cd traefik-helm-chart/traefik

kubectl create ns traefik

helm install traefik /root/v39.0.7 --namespace traefik -f values.yaml --wait

kubectl get pods -n traefik -o jsonpath='{.items[0].spec.containers[0].image}'
```