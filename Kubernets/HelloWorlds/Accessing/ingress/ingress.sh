# Enable ingress on minikube
minikube addons enable ingress
minikube addons list
MINIKUBE_HOST=192.168.99.100

# Create deployments and services
kubectl create -f deployment-goku.yaml
kubectl create -f deployment-jiren.yaml

kubectl create -f service-goku.yaml
kubectl create -f service-jiren.yaml

curl http://$MINIKUBE_HOST:`kubectl get svc goku-service -o yaml | grep nodePort | cut -d' ' -f6`/goku
curl http://$MINIKUBE_HOST:`kubectl get svc jiren-service -o yaml | grep nodePort | cut -d' ' -f6`/jiren

# Ingress without host
kubectl create -f ingress-hello.yaml

kubectl get ingress

curl -k https://$MINIKUBE_HOST/goku
curl -k https://$MINIKUBE_HOST/jiren
curl -k https://$MINIKUBE_HOST/gohan # default backend - 404

# Ingress with host
kubectl create -f ingress-hello-host.yaml

kubectl get ingress

IC_HTTPS_PORT=443
curl --resolve ingresshello.example.com:$IC_HTTPS_PORT:$MINIKUBE_HOST https://ingresshello.example.com:$IC_HTTPS_PORT/goku --insecure
curl --resolve ingresshello.example.com:$IC_HTTPS_PORT:$MINIKUBE_HOST https://ingresshello.example.com:$IC_HTTPS_PORT/jiren --insecure
curl --resolve ingresshello.example.com:$IC_HTTPS_PORT:$MINIKUBE_HOST https://ingresshello.example.com:$IC_HTTPS_PORT/gohan --insecure
