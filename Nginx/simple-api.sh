DEFAULT_PORT=${1:-8080}
NAME=simpleapi_${DEFAULT_PORT}

docker rm -f $NAME
docker run -d --name $NAME -p $DEFAULT_PORT:8080 \
   -v $PWD/api/index.js:/usr/src/simpleapi/index.js \
   -v $PWD/api/public:/usr/src/simpleapi/public \
   emondek/simple-api:latest