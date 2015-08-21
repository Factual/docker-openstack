FROM factual/docker-base
MAINTAINER Maxime DEVALLAND <maxime@factual.com>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5EDB1B62EC4926EA
RUN echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main" > /etc/apt/sources.list.d/cloudarchive-kilo.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes wget curl ntp ubuntu-cloud-keyring glance python-mysqldb python-glanceclient && rm -r /var/lib/apt/lists/*

RUN mkdir -p /etc/my_init.d/ /etc/service/glance-registry /etc/service/glance-api
ADD init.sh /etc/my_init.d/00_init.sh
ADD glance-registry.sh /etc/service/glance-registry/run
ADD glance-api.sh /etc/service/glance-api/run

EXPOSE 9292 9191
