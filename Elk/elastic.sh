docker rm -f elasticsearch
docker run -h elasticsearch --name elasticsearch -d -p 9200:9200 -p 9300:9300 elasticsearch
