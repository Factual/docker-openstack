#!/bin/bash
/usr/sbin/rabbitmq-server &
sleep 2
rabbitmqctl add_user openstack rabbitpassword
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
killall -9 rabbitmq-server
