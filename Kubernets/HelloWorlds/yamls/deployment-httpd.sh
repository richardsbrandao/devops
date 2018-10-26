kubectl create -f deployment-httpd.yaml
kubectl get deployments
kubectl delete deployments httpd-deployment
kubectl scale --replicas=5 deployment/httpd-deployment
kubectl get deployments