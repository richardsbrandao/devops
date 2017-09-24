# Dockerizing uma imagem MongoDb para aprender esse bagaça :)
#

# A imagem sera buildada a partir da ultima versao do ubuntu no DockerHub
FROM 	ubuntu:latest

# O criador da imagem
MAINTAINER Richard Brandão <richardsbrandao@gmail.com>

# INSTALACAO

# Adicionando MongoDb do repositorio oficial
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

# Atualizando apt-get e instalando o mongodb
RUN apt-get update && apt-get install -y mongodb-org

# Criando diretorio de dados do Mongo
RUN mkdir -p /data/db

# Expõe a porta padrão do mongo  da VM do Docker
EXPOSE 27017

# Executa o comando abaixo assim que a VM startar
ENTRYPOINT /usr/bin/mongod

#### ####
## Apos a Configuracao
### #####

# Buildar a imagem 
# sintaxe: docker build --tag {userName}/{image}
# docker build --tag my/hello .

# Log in no docker
# sudo docker login

# Fazer push para o repositorio do Docker
# sudo docker push {userName}/{image}

# 
# docker push richardbrandao/estudos
