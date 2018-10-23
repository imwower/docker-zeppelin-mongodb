FROM ubuntu:16.04

ENV ZEPPELIN_VERSION=0.8.0 \
    ZEPPELIN_HOME=/opt/zeppelin \
    MONGO_VERSION=3.4

USER root
RUN apt-get update && apt-get install -y wget gnupg
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list

RUN apt-get update && \
	apt-get install -y \
	curl \
	openssl \
	openjdk-8-jdk \
	git \
	mongodb-org-shell

RUN mkdir -p ${ZEPPELIN_HOME}

RUN curl -o zeppelin-0.8.0-bin-all.tar.gz.001 https://github.com/imwower/docker-zeppelin-mongodb/releases/download/v0.8.0/zeppelin-0.8.0-bin-all.tar.gz.001
RUN curl -o zeppelin-0.8.0-bin-all.tar.gz.002 https://github.com/imwower/docker-zeppelin-mongodb/releases/download/v0.8.0/zeppelin-0.8.0-bin-all.tar.gz.002
RUN curl -o zeppelin-0.8.0-bin-all.tar.gz.003 https://github.com/imwower/docker-zeppelin-mongodb/releases/download/v0.8.0/zeppelin-0.8.0-bin-all.tar.gz.003
RUN curl -o zeppelin-0.8.0-bin-all.tar.gz.004 https://github.com/imwower/docker-zeppelin-mongodb/releases/download/v0.8.0/zeppelin-0.8.0-bin-all.tar.gz.004
RUN curl -o zeppelin-0.8.0-bin-all.tar.gz.005 https://github.com/imwower/docker-zeppelin-mongodb/releases/download/v0.8.0/zeppelin-0.8.0-bin-all.tar.gz.005

RUN cat zeppelin-0.8.0-bin-all.tar.gz.* > zeppelin-${ZEPPELIN_VERSION}-bin-all.tar.gz

RUN tar -xzvf zeppelin-${ZEPPELIN_VERSION}-bin-all.tar.gz && \
        mv zeppelin-${ZEPPELIN_VERSION}-bin-all/* ${ZEPPELIN_HOME} && \
        rm -rf zeppelin-${ZEPPELIN_VERSION}-bin-all && \
        rm -rf *.tar.*

EXPOSE 8080

VOLUME ${ZEPPELIN_HOME}/logs ${ZEPPELIN_HOME}/notebook

CMD ${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh start; sleep 5; tail -F ${ZEPPELIN_HOME}/logs/zeppelin-*.log