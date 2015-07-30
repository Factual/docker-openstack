FROM ubuntu:14.04
MAINTAINER Maxime DEVALLAND <maxime@factual.com>
RUN echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main" > /etc/apt/sources.list.d/cloudarchive-kilo.list
RUN apt-get update && apt-get install -y --force-yes ntp ubuntu-cloud-keyring mariadb-server python-mysqldb rabbitmq-server && rm -r /var/lib/apt/lists/*

