#!/bin/bash

# init logstash
ansible-playbook -i logstash/inventories/aws_ec2.yml logstash/logstash.yml

# init filebeat
ansible-playbook -i filebeat/inventories/aws_ec2.yml filebeat/filebeat.yml
