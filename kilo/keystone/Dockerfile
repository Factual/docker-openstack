FROM factual/docker-base
MAINTAINER Maxime DEVALLAND <maxime@factual.com>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5EDB1B62EC4926EA
RUN echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main" > /etc/apt/sources.list.d/cloudarchive-kilo.list
RUN echo "manual" > /etc/init/keystone.override
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes wget curl ntp ubuntu-cloud-keyring keystone python-mysqldb python-openstackclient apache2 libapache2-mod-wsgi memcached python-memcache && rm -r /var/lib/apt/lists/*

RUN mkdir -p /etc/my_init.d/ /etc/service/keystone
ADD init.sh /etc/my_init.d/00_init.sh
ADD keystone.sh /etc/service/keystone/run

EXPOSE 5000 35357
