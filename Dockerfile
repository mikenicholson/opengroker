FROM phusion/baseimage:0.9.18

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y openjdk-7-jre-headless git subversion tomcat7 exuberant-ctags curl

ENV opengrok_dist_url https://java.net/projects/opengrok/downloads/download/opengrok-0.12.1.tar.gz
RUN mkdir /opengrok
RUN curl -L ${opengrok_dist_url} | tar xvz -C /opengrok --strip-components=1

ENV OPENGROK_INSTANCE_BASE /var/opengrok
RUN mkdir -p ${OPENGROK_INSTANCE_BASE}/etc
RUN mkdir -p ${OPENGROK_INSTANCE_BASE}/data

RUN /opengrok/bin/OpenGrok deploy

RUN mkdir -p /etc/my_init.d
ADD start_tomcat.sh /etc/my_init.d/start_tomcat.sh
ADD opengrok-crontab /etc/cron.d/opengrok 
ADD reindex.sh /opengrok/scripts/reindex.sh

ENV OPENGROK_SOURCE_DIR /src

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
EXPOSE 8080
