FROM debian:stretch-slim

LABEL authors="Rohit Jagtiani <rjagtiani@intercomempresas.com>"
LABEL version="1.1"

ARG USER=logstash
ARG GROUP=logstash
ARG UID=1000
ARG GID=1000
ARG ENV=prod

ENV APP_USER_ID         $UID
ENV APP_GROUP_ID        $GID
ENV APP_ENV				$ENV

#Base packages debian

RUN apt-get update && apt-get -y install libxml2-dev zlib1g-dev \
	wget curl gcc \
	libc-dev pkg-config \
	libmcrypt-dev openssl \
	apt-utils 

#Java install

RUN mkdir -p /usr/share/man/man1 \
	&& apt install -y openjdk-8-jdk

#Logstash install

RUN apt-get -y install apt-transport-https gnupg1 gnupg2 gnupg \
	&& wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
	&& echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list

RUN apt-get update && apt-get -y install logstash

RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-aggregate \
	&& chown -R logstash:logstash /etc/logstash/ && chown -R logstash:logstash  /var/lib/logstash \
	&& usermod -u $APP_USER_ID logstash && groupmod -g $APP_GROUP_ID logstash 

CMD ["/bin/sh", "-c", "/usr/share/logstash/bin/logstash --path.settings=/etc/logstash/"]
