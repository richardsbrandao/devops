# Create Deployment
kubectl create -f nginx-rollingUpdate.yaml

kubectl get deployments -o wide
kubectl describe pods nginx | grep -i image

# Rolling Update
kubectl set image deployment nginx nginx=nginx:1.15.5-alpine

kubectl describe pods nginx | grep -i image
kubectl get deployments -o wide

kubectl rollout history deployment nginx
kubectl rollout history deployment nginx --revision=1
kubectl rollout history deployment nginx --revision=2

# Rollback
kubectl rollout undo deployment nginx --to-revision=1

kubectl get deployments -o wide
kubectl rollout history deployment nginx
kubectl rollout history deployment nginx --revision=2
kubectl rollout history deployment nginx --revision=3