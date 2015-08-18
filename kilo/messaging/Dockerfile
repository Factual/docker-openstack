FROM ubuntu:14.04
MAINTAINER Maxime DEVALLAND <maxime@factual.com>
RUN echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main" > /etc/apt/sources.list.d/cloudarchive-kilo.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes ntp ubuntu-cloud-keyring rabbitmq-server && rm -r /var/lib/apt/lists/*

CMD ['/usr/sbin/rabbitmq-server']
