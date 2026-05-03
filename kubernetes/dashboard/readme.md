# 访问默认的控制台

> https://192.168.235.128:30638

```shell
[root@easzlab openkruise-v1.7.5]# kubectl get svc -o wide -n kube-system
NAME                        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
dashboard-metrics-scraper   ClusterIP   10.68.226.197   <none>        8000/TCP                 37d   k8s-app=dashboard-metrics-scraper
kube-dns                    ClusterIP   10.68.0.2       <none>        53/UDP,53/TCP,9153/TCP   37d   k8s-app=kube-dns
kube-dns-upstream           ClusterIP   10.68.249.252   <none>        53/UDP,53/TCP            37d   k8s-app=kube-dns
kubernetes-dashboard        NodePort    10.68.209.241   <none>        443:30638/TCP            37d   k8s-app=kubernetes-dashboard
metrics-server              ClusterIP   10.68.164.209   <none>        443/TCP                  37d   k8s-app=metrics-server
node-local-dns              ClusterIP   None            <none>        9253/TCP                 37d   k8s-app=node-local-dns

[root@easzlab openkruise-v1.7.5]# kubectl create serviceaccount dashboard-admin -n kube-system
serviceaccount/dashboard-admin created

[root@easzlab openkruise-v1.7.5]# kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin --serviceaccount=kube-system:dashboard-admin
clusterrolebinding.rbac.authorization.k8s.io/dashboard-admin created

[root@easzlab openkruise-v1.7.5]# kubectl -n kube-system create token dashboard-admin
eyJhbGciOiJSUzI1NiIsImtpZCI6IktDOF9KU3ZxUUxBbGo0bmN0b1dOV0w2VnR3ZXpEWDhJRjIwdFp2WWpSbnMifQ.eyJhdWQiOlsiYXBpIiwiaXN0aW8tY2EiXSwiZXhwIjoxNzc3Nzc5MjQ0LCJpYXQiOjE3Nzc3NzU2NDQsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2YyIsImt1YmVybmV0ZXMuaW8iOnsibmFtZXNwYWNlIjoia3ViZS1zeXN0ZW0iLCJzZXJ2aWNlYWNjb3VudCI6eyJuYW1lIjoiZGFzaGJvYXJkLWFkbWluIiwidWlkIjoiNzhlYmNkMTItNzU0OS00NjE0LThhNzgtZjA4NTRjOGNlYWZlIn19LCJuYmYiOjE3Nzc3NzU2NDQsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTpkYXNoYm9hcmQtYWRtaW4ifQ.CZa1Yv4CVaXp5yrMVJTkut1e-EVEZ6tN1SE38b3cNaYlGGBYCtC3xIpUULtDGkTP-4GFuEfcIEz0uo0DUG67F85VWkWMcJnqB8coubiGA90YS8H3kfvTkgtssxPNjDQ8H2mPsU1oqUqb31LVFBZcoelcHn9937j-vXxwbIF0uxpV98tru8nG0c7i1ZTdqZwcwkIU8o1fykkah_6fYrqBxZ9PKeQFcgLRN3U3XkCouoXkSsGfnN4OLD875UZjNqggdfCBibNGRIi8MklymO19bQrlZnfSK-wwpWzxNboBwCbBcMaPfgKLnQXacLp5XsU9AgSKMDcEdMXnH5Psjr5XAw
```
