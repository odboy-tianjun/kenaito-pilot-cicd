## ingress-nginx-controller-v1.12.0

#### deploy和deploy-hostNetwork的区别

- deploy endpoint为内网IP

```text
# kubectl describe svc xx

Endpoints: 172.20.65.95:80
Endpoints: 172.20.65.95:443
```

- deploy-hostNetwork endpoint为宿主机IP（推荐）

```text
# kubectl describe svc xx

Endpoints: 192.168.235.101:80
Endpoints: 192.168.235.101:443
```

#### 安装方式
```shell
sh install.sh
```

