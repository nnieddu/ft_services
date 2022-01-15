chown -R root:root /etc/grafana && \
chmod -R a+r /etc/grafana && \
chown -R grafana:grafana /var/lib/grafana && \
chown -R grafana:grafana /usr/share/grafana
grafana-server --homepath="/usr/share/grafana" --config="./grafana.ini" --packaging=docker