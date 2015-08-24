#!/bin/bash
sleep 15
rabbitmqctl add_user openstack rabbitpassword
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
