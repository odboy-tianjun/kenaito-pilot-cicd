# 集群Nginx代理(7层负载)

> 版本选择参考官方文档 https://kubernetes.github.io/ingress-nginx/

# 开源地址

https://github.com/kubernetes/ingress-nginx

# 安装脚本

> https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.15.1/deploy/static/provider/cloud/deploy.yaml

```shell
# dockerhub
kubectl apply -f deploy.yml

# 阿里云
kubectl apply -f deploy.cn.yml

# 阿里云 && 本地网络 && 测试学习使用
# 启用hostNetwork, 将域名解析到任意节点（因为ingress-nginx是daemonset）就可以访问对应的pod服务
kubectl apply -f deploy.cn.hostNetwork.yaml

# 观察控制器是否准备就绪
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
```

# deploy.cn 和 deploy.cn.hostNetwork 的区别

- deploy.cn endpoint为内网IP

```text
# kubectl describe svc xx

Endpoints: 172.20.65.95:80
Endpoints: 172.20.65.95:443
```

- deploy.cn.hostNetwork endpoint为宿主机IP

```text
# kubectl describe svc xx

Endpoints: 192.168.235.101:80
Endpoints: 192.168.235.101:443
```
