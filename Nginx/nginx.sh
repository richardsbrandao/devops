docker rm -f nginx_example
docker run -d --name nginx_example -p 9090:80 -v $PWD/nginx.conf:/etc/nginx/nginx.conf:ro nginx:1.11