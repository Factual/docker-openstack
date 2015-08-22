#!/bin/bash
#service glance-registry stop
#service glance-api stop

OS_GLANCE_DB_PASSWORD=${OS_GLANCE_DB_PASSWORD:-glance}
OS_GLANCE_PASSWORD=${OS_GLANCE_PASSWORD:-glance}
OS_URL=${OS_URL:-controller}
OS_DB_URL=${OS_DB_URL:-controller}
OS_MESSAGING_URL=${OS_MESSAGING_URL:-localhost}
OS_MESSAGING_USER=${OS_MESSAGING_USER:-guest}
OS_MESSAGING_PASSWORD=${OS_MESSAGING_PASSWORD:-guest}


# Glance API
sed -i "s|#connection = .*|connection = mysql://glance:$OS_GLANCE_DB_PASSWORD@$OS_DB_URL/glance|g" /etc/glance/glance-api.conf
sed -i "s|identity_uri = http://127.0.0.1:35357|identity_uri = http://$OS_URL:35357|g" /etc/glance/glance-api.conf
sed -i "/keystone_authtoken]/a \
auth_uri = http://$OS_URL:5000\n\
auth_url = http://$OS_URL:35357\n\
auth_plugin = password\n\
project_domain_id = default\n\
user_domain_id = default\n\
project_name = service\n\
username = glance\n\
password = $OS_GLANCE_PASSWORD" /etc/glance/glance-api.conf
sed -i "s|#flavor=|flavor=keystone|g" /etc/glance/glance-api.conf
sed -i "0,/DEFAULT]/a notification_driver = noop" /etc/glance/glance-api.conf

sed -i "s|rabbit_host.*|rabbit_host = $OS_MESSAGING_URL|g" /etc/glance/glance-api.conf
sed -i "s|rabbit_userid.*|rabbit_userid = $OS_MESSAGING_USER|g" /etc/glance/glance-api.conf
sed -i "s|rabbit_password.*|rabbit_password = $OS_MESSAGING_PASSWORD|g" /etc/glance/glance-api.conf

sed -i "s|qpid_hostname.*|qpid_hostname = $OS_MESSAGING_URL|g" /etc/glance/glance-api.conf
sed -i "s|qpid_username.*|qpid_username = $OS_MESSAGING_USER|g" /etc/glance/glance-api.conf
sed -i "s|qpid_password.*|qpid_password = $OS_MESSAGING_PASSWORD|g" /etc/glance/glance-api.conf

# Glance Registry
sed -i "s|#connection = .*|connection = mysql://glance:$OS_GLANCE_DB_PASSWORD@$OS_DB_URL/glance|g" /etc/glance/glance-registry.conf
sed -i "s|identity_uri = http://127.0.0.1:35357|identity_uri = http://$OS_URL:35357|g" /etc/glance/glance-registry.conf
sed -i "/keystone_authtoken]/a \
auth_uri = http://$OS_URL:5000\n\
auth_url = http://$OS_URL:35357\n\
auth_plugin = password\n\
project_domain_id = default\n\
user_domain_id = default\n\
project_name = service\n\
username = glance\n\
password = $OS_GLANCE_PASSWORD " /etc/glance/glance-registry.conf
sed -i "s|#flavor=|flavor=keystone|g" /etc/glance/glance-registry.conf
sed -i "0,/DEFAULT]/a notification_driver = noop" /etc/glance/glance-registry.conf 

sed -i "s|rabbit_host.*|rabbit_host = $OS_MESSAGING_URL|g" /etc/glance/glance-registry.conf
sed -i "s|rabbit_userid.*|rabbit_userid = $OS_MESSAGING_USER|g" /etc/glance/glance-registry.conf
sed -i "s|rabbit_password.*|rabbit_password = $OS_MESSAGING_PASSWORD|g" /etc/glance/glance-registry.conf

sed -i "s|qpid_hostname.*|qpid_hostname = $OS_MESSAGING_URL|g" /etc/glance/glance-registry.conf
sed -i "s|qpid_username.*|qpid_username = $OS_MESSAGING_USER|g" /etc/glance/glance-registry.conf
sed -i "s|qpid_password.*|qpid_password = $OS_MESSAGING_PASSWORD|g" /etc/glance/glance-registry.conf

# Removing default SQLite DB
rm -f /var/lib/glance/glance.sqlite

glance-manage db_sync
