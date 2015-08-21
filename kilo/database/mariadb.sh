#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

# Download MySQL Conf
wget -q http://resources.prod.factual.com/services/openstack/mysqld_openstack.cnf -O /etc/mysql/conf.d/mysqld_openstack.cnf

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MariaDB volume is detected in $VOLUME_HOME"
    echo "=> Installing MariaDB ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"  
    /etc/my_init.d/00_create_mariadb_admin_user.sh
else
    echo "=> Using an existing volume of MariaDB"
fi

exec mysqld_safe
