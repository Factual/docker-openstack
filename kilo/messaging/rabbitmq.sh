#!/bin/bash
rabbitmqctl add_user openstack rabbitpassword
rabbitmqctl set_permissions openstack ".*" ".*" ".*"

/usr/sbin/rabbitmq-server
