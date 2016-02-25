FROM phusion/baseimage:0.9.18

# Install necessary packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    curl \
    exuberant-ctags \
    git \
    openjdk-7-jre-headless \
    subversion \
    tomcat7 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install opengrok
ENV opengrok_dist_url https://java.net/projects/opengrok/downloads/download/opengrok-0.12.1.tar.gz
RUN mkdir /opengrok && curl -s -L ${opengrok_dist_url} | tar xvz -C /opengrok --strip-components=1

# Deploy opengrok
ENV OPENGROK_INSTANCE_BASE /var/opengrok
RUN mkdir -p ${OPENGROK_INSTANCE_BASE}/{etc,data} && /opengrok/bin/OpenGrok deploy

# Add maintenance scripts
ADD start_tomcat.sh /etc/my_init.d/start_tomcat.sh
ADD opengrok-crontab /etc/cron.d/opengrok 
ADD reindex.sh /opengrok/scripts/reindex.sh

ENV OPENGROK_SOURCE_DIR /src

# Use baseimage-docker's init system.
CMD env > /tmp/myEnv.sh && /sbin/my_init
EXPOSE 8080
