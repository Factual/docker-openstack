FROM factual/docker-base
MAINTAINER Maxime DEVALLAND <maxime@factual.com>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5EDB1B62EC4926EA
RUN echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main" > /etc/apt/sources.list.d/cloudarchive-kilo.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes wget curl ntp ubuntu-cloud-keyring nova-api nova-cert nova-conductor nova-consoleauth nova-novncproxy nova-scheduler python-novaclient python-mysqldb && rm -r /var/lib/apt/lists/*
RUN curl -L http://github.com/micha/jsawk/raw/master/jsawk > /bin/jsawk
RUN chmod 755 /bin/jsawk

RUN mkdir -p /etc/my_init.d/ /etc/service/nova
ADD init.sh /etc/my_init.d/00_init.sh
ADD nova.sh /etc/service/nova/run

EXPOSE 8774


