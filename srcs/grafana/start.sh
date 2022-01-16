#!/bin/sh

mkdir -p /usr/share/grafana/conf/provisioning/datasources
mkdir -p /usr/share/grafana/conf/provisioning/dashboards
mkdir -p /var/lib/grafana/dashboards

chown -R root:root /etc/grafana && \
chmod -R a+r /etc/grafana && \
chown -R grafana:grafana /var/lib/grafana && \
chown -R grafana:grafana /usr/share/grafana
grafana-server --homepath="/usr/share/grafana" --config="./grafana.ini" --packaging=docker