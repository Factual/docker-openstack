#!/bin/bash
NOVA_URL=`curl http://marathon.la.prod.factual.com/v2/apps/openstack-nova`


OS_NOVA_DB_PASSWORD=${OS_NOVA_DB_PASSWORD:-NOVA}
OS_NOVA_PASSWORD=${OS_NOVA_PASSWORD:-NOVA}
OS_URL=${OS_URL:-controller}
OS_DB_URL=${OS_DB_URL:-controller}
OS_MESSAGING_URL=${OS_MESSAGING_URL:-localhost}
OS_MESSAGING_USER=${OS_MESSAGING_USER:-guest}
OS_MESSAGING_PASSWORD=${OS_MESSAGING_PASSWORD:-guest}


# NOVA API
echo "
[database]
connection = mysql://nova:$OS_NOVA_DB_PASSWORD@$OS_DB_URL/nova" >> /etc/nova/nova.conf
sed -i "0,/DEFAULT]/a \
rpc_backend = rabbit\n
auth_strategy = keystone" /etc/nova/nova.conf

echo "[keystone_authtoken]
auth_uri = http://$OS_URL:5000\n\
auth_url = http://$OS_URL:35357\n\
auth_plugin = password\n\
project_domain_id = default\n\
user_domain_id = default\n\
project_name = service\n\
username = nova\n\
password = $OS_NOVA_PASSWORD" >> /etc/nova/nova.conf

echo "[oslo_messaging_rabbit]
rabbit_host = $OS_URL
rabbit_userid = $OS_MESSAGING_USER
rabbit_password = $OS_MESSAGING_PASSWORD" >> /etc/nova/nova.conf

echo "[glance]
host = $OS_URL" >> /etc/nova/nova.conf

echo "[oslo_concurrency]
lock_path = /var/lib/nova/tmp" >> /etc/nova/nova.conf

rm -f /var/lib/nova/nova.sqlite

nova-manage db sync
