#!/bin/bash

OS_KEYSTONE_ADMIN_TOKEN=${OS_KEYSTONE_ADMIN_TOKEN:-ADMIN}
sed -i "s/#admin_token=ADMIN/admin_token=$OS_KEYSTONE_ADMIN_TOKEN/g" /etc/keystone/keystone.conf
