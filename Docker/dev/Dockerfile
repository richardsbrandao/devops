FROM ubuntu:14.04
MAINTAINER Richard Brandão <richardsbrandao@gmail.com>

#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# apt-get update
# apt-get install -y software-properties-common

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get update
apt-get install -y oracle-java8-installer


#RUN add-apt-repository -y ppa:webupd8team/java
#RUN apt-get update -y
#RUN apt-get install -y oracle-java8-installer


#ENV SDKMAN_DIR $HOME

RUN set -x \
    && apt-get update \
    && apt-get install -y unzip --no-install-recommends \
    && apt-get install -y curl vim \
    && rm -rf /var/lib/apt/lists/*

RUN curl -s get.sdkman.io | bash

RUN set -x \
    && echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \
    && echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_insecure_ssl=false" >> $SDKMAN_DIR/etc/config

export JAVA_HOME=/usr/local/...
RUN /bin/bash -c "sdk install java 8"

RUN mkdir /work