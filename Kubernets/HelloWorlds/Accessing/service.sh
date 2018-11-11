kubectl run http --image=httpd
kubectl get deployments

kubectl expose deployment http --port=80 --type=NodePort

kubectl get services

curl http://192.168.99.100:`kubectl get svc http -o yaml | grep nodePort | cut -d' ' -f5`