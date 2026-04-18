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
# 安装（需要一段时间才能生效，大概5~10分钟，使用kubectl get，然后tab键，就能看到对应的快捷提示了）
helm install kruise /root/kruise-1.4.2.cn.tgz

# 升级
helm upgrade kruise /root/kruise-1.5.5.cn.tgz
```

# 验证是否生效（以下是测试流程）
```shell
[root@easzlab kruise-v1.7.5]# kubectl get pods -n kruise-system
NAME                                        READY   STATUS    RESTARTS        AGE
kruise-controller-manager-5d58bcb6c-97k9l   1/1     Running   1 (3m29s ago)   5m38s
kruise-controller-manager-5d58bcb6c-gn25c   1/1     Running   1 (3m29s ago)   5m38s
kruise-daemon-pr5p2                         1/1     Running   1 (3m29s ago)   5m38s

[root@easzlab kruise-v1.7.5]# helm list
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
kruise  default         1               2026-04-18 09:19:42.992859098 +0800 CST deployed        kruise-1.7.5    1.7.5

[root@easzlab kruise-v1.7.5]# kubectl get crd clonesets.apps.kruise.io
NAME                       CREATED AT
clonesets.apps.kruise.io   2026-04-18T01:19:43Z

[root@easzlab kruise-v1.7.5]# kubectl get crd | grep kruise.io
advancedcronjobs.apps.kruise.io            2026-04-18T01:19:43Z
broadcastjobs.apps.kruise.io               2026-04-18T01:19:43Z
clonesets.apps.kruise.io                   2026-04-18T01:19:43Z
containerrecreaterequests.apps.kruise.io   2026-04-18T01:19:43Z
daemonsets.apps.kruise.io                  2026-04-18T01:19:43Z
imagelistpulljobs.apps.kruise.io           2026-04-18T01:19:43Z
imagepulljobs.apps.kruise.io               2026-04-18T01:19:43Z
nodeimages.apps.kruise.io                  2026-04-18T01:19:43Z
nodepodprobes.apps.kruise.io               2026-04-18T01:19:43Z
persistentpodstates.apps.kruise.io         2026-04-18T01:19:43Z
podprobemarkers.apps.kruise.io             2026-04-18T01:19:43Z
podunavailablebudgets.policy.kruise.io     2026-04-18T01:19:43Z
resourcedistributions.apps.kruise.io       2026-04-18T01:19:43Z
sidecarsets.apps.kruise.io                 2026-04-18T01:19:43Z
statefulsets.apps.kruise.io                2026-04-18T01:19:43Z
uniteddeployments.apps.kruise.io           2026-04-18T01:19:43Z
workloadspreads.apps.kruise.io             2026-04-18T01:19:43Z
```
