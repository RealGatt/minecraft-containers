FROM debian:10.5-slim

RUN	apt update && apt upgrade -y \
	&& apt install -y gnupg \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
		--recv-keys 0xB1998361219BD9C9 \
	&& echo "deb http://repos.azulsystems.com/debian stable main" >> /etc/apt/sources.list.d/zulu.list \
	&& mkdir -p /usr/share/man/man1 \
	&& apt update \
	&& apt install -y curl ca-certificates openssl git tar sqlite fontconfig iproute2 tzdata openjdk-15-jdk \
	&& useradd -d /home/container -m container
 
RUN java -version
 
USER container
ENV	USER=container HOME=/home/container

WORKDIR	/home/container

# Expose Port for Grafana/Prometheus
EXPOSE 9797

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
