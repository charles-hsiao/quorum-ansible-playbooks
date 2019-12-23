#!/bin/bash

# init prometheus
ansible-playbook prometheus/prometheus.yml

# init grafana
ansible-playbook grafana/grafana.yml
