# Pod Level
kubectl run http --image=httpd

kubectl port-forward `kubectl get pods | grep http | cut -d' ' -f1` 8080:80 &
curl http://localhost:8080
