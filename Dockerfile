FROM openjdk:15-alpine
WORKDIR /root

# Set up base system
RUN apt-get -y update \
    && apt-get -y install curl git tar iproute2 unzip \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \
    && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
    && rm -rf /var/lib/apt/lists/*

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
