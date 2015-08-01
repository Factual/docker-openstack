FROM factual/docker-base
MAINTAINER Maxime DEVALLAND <maxime@factual.com>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5EDB1B62EC4926EA
RUN echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main" > /etc/apt/sources.list.d/cloudarchive-kilo.list
RUN apt-get update && apt-get install -y --force-yes ntp pwgen ubuntu-cloud-keyring mariadb-server python-mysqldb && rm -r /var/lib/apt/lists/*

RUN sed -i -r 's/bind-address.*$/bind-address = 0.0.0.0/' /etc/mysql/my.cnf
RUN rm -rf /var/lib/mysql 

ADD create_mariadb_admin_user.sh /create_mariadb_admin_user.sh
ADD run.sh /run.sh
RUN chmod 775 /*.sh

EXPOSE 3306
CMD ["/run.sh"]
