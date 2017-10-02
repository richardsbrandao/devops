docker rm -f logstash
docker run -d -h logstash --name logstash -p 5044:5044 --link elasticsearch:elasticsearch -v $PWD/logstash:/logstash logstash -f /logstash/logstash.conf