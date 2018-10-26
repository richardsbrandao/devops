minikube start
kubectl cluster-info

kubectl run hello-kubernets-nginx --image=nginx --replicas=2 --port=80

kubectl get pod hello-kubernets-nginx-6db9778596-wjh2p -o yaml
kubectl get deployments hello-kubernets-nginx -o yaml
