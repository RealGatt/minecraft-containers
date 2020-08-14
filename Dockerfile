FROM openjdk:15-alpine
WORKDIR /root

# Set up base system
RUN apk update \
    && apk install curl git tar iproute2 unzip

# Set up container user
RUN    groupadd -g 1000 container \
    && useradd -d /home/container -m -u 1000 -g 1000 container

# Set up default user and environment
USER container
ENV USER=container HOME=/home/container LANG=en_US.UTF-8
WORKDIR /home/container

# Expose Port for Grafana/Prometheus
EXPOSE 9797

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
