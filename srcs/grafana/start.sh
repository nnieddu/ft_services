sed -i "s/MYSQL_SERVICE_SERVICE_HOST/$MYSQL_SERVICE_SERVICE_HOST/g" grafana.ini


grafana-server --homepath="/usr/share/grafana" --config="./grafana.ini" --packaging=docker