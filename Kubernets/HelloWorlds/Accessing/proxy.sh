kubectl proxy &
ps aux | grep 'kubectl proxy'

curl http://localhost:8001/apis/apps/v1/deployments
curl http://localhost:8001/version