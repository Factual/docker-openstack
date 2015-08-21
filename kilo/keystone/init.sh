#!/bin/bash

OS_KEYSTONE_ADMIN_TOKEN=${OS_KEYSTONE_ADMIN_TOKEN:-ADMIN}
OS_KEYSTONE_DB_PASSWORD=${OS_KEYSTONE_DB_PASSWORD:-keystone}
OS_DB_URL=${OS_DB_URL:-controller}

sed -i "s/#admin_token.*/admin_token=$OS_KEYSTONE_ADMIN_TOKEN/g" /etc/keystone/keystone.conf
sed -i "s|connection = sqlite.*|connection = mysql://keystone:$OS_KEYSTONE_DB_PASSWORD@$OS_DB_URL/keystone|g" /etc/keystone/keystone.conf
sed -i "s|#provider = keystone.token.providers.uuid.Provider|provider = keystone.token.providers.uuid.Provider|g" /etc/keystone/keystone.conf
sed -i "s|#driver = keystone.token.persistence.backends.sql.Token|driver = keystone.token.persistence.backends.memcache.Token|g" /etc/keystone/keystone.conf
sed -i "s|#driver = keystone.contrib.revoke.backends.sql.Revoke|driver = keystone.contrib.revoke.backends.sql.Revoke|g" /etc/keystone/keystone.conf
sed -i "s|#verbose = false|verbose = true|g" /etc/keystone/keystone.conf

# Download Virtulhost
wget -q http://resources.prod.factual.com/services/openstack/keystone/wsgi-keystone.conf -O /etc/apache2/sites-available/wsgi-keystone.conf

# Enable Virtualhost
a2dissite 000-default
a2ensite wsgi-keystone

# Configuring Keystone
mkdir -p /var/www/cgi-bin/keystone
curl http://git.openstack.org/cgit/openstack/keystone/plain/httpd/keystone.py?h=stable/kilo  | tee /var/www/cgi-bin/keystone/main /var/www/cgi-bin/keystone/admin
chown -R keystone:keystone /var/www/cgi-bin/keystone
chmod 755 /var/www/cgi-bin/keystone/*
rm -f /var/lib/keystone/keystone.db


