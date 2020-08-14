FROM openjdk:15-alpine
WORKDIR /root

RUN java -version

# Set up base system
RUN apk update \
    && apk add  curl ca-certificates openssl git tar sqlite fontconfig tzdata iproute2 unzip
 
USER container
ENV  USER=container HOME=/home/container

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

# Expose Port for Grafana/Prometheus
EXPOSE 9797

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
