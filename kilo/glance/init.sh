#!/bin/bash
#service glance-registry stop
#service glance-api stop

OS_GLANCE_DB_PASSWORD=${OS_GLANCE_DB_PASSWORD:-glance}
OS_GLANCE_PASSWORD=${OS_GLANCE_PASSWORD:-glance}
OS_URL=${OS_URL:-controller}
OS_DB_URL=${OS_DB_URL:-controller}

# Glance API
sed -i "s|#connection = .*|connection = mysql://glance:$OS_GLANCE_DB_PASSWORD@$OS_DB_URL/glance|g" /etc/glance/glance-api.conf
sed -i "s|identity_uri = http://127.0.0.1:35357|identity_uri = http://$OS_URL:35357|g" /etc/glance/glance-api.conf
sed -i "/keystone_authtoken]/a \
auth_uri = http://$OS_URL:5000 \n \
auth_url = http://$OS_URL:35357 \n \
auth_plugin = password \n \
project_domain_id = default \n \
user_domain_id = default \n \
project_name = service \n \
username = glance \n \
password = $OS_GLANCE_PASSWORD " /etc/glance/glance-api.conf
sed -i "s|#flavor=|flavor=keystone|g" /etc/glance/glance-api.conf
sed -i "/DEFAULT]/a notification_driver = noop" /etc/glance/glance-api.conf


# Glance Registry
sed -i "s|#connection = .*|connection = mysql://glance:$OS_GLANCE_DB_PASSWORD@$OS_DB_URL/glance|g" /etc/glance/glance-registry.conf
sed -i "s|identity_uri = http://127.0.0.1:35357|identity_uri = http://$OS_URL:35357|g" /etc/glance/glance-registry.conf
sed -i "/keystone_authtoken]/a \
auth_uri = http://$OS_URL:5000 \n \
auth_url = http://$OS_URL:35357 \n \
auth_plugin = password \n \
project_domain_id = default \n \
user_domain_id = default \n \
project_name = service \n \
username = glance \n \
password = $OS_GLANCE_PASSWORD " /etc/glance/glance-registry.conf
sed -i "s|#flavor=|flavor=keystone|g" /etc/glance/glance-registry.conf
sed -i "/DEFAULT]/a notification_driver = noop" /etc/glance/glance-registry.conf 

# Removing default SQLite DB
rm -f /var/lib/glance/glance.sqlite

glance-manage db_sync
