#kubectl apply -f deploy.yaml
kubectl apply -f deploy-hostNetwork.yaml
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
