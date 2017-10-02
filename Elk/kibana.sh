docker rm -f kibana
docker run --name kibana -h kibana --link elasticsearch:elasticsearch -p 5601:5601 -d kibana
