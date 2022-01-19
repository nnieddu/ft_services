#!/bin/bash

minikube start --driver=virtualbox
minikube addons enable metallb

MY_CLUSTER_IP=$(minikube ip)

eval $(minikube docker-env)

#--Metallb--
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# sed -i "s/_IP_/$MY_CLUSTER_IP/g" srcs/metallb-conf.yaml
# kubectl apply -f srcs/metallb-conf.yaml
# sed -i "s/$MY_CLUSTER_IP/_IP_/g" srcs/metallb-conf.yaml srcs/backupmlb.yaml

#MACOS SCHOOL VERSION (sed -i marche pas sur mac) : 
perl -i -pe"s/_IP_/$MY_CLUSTER_IP/g" srcs/metallb-conf.yaml
kubectl apply -f srcs/metallb-conf.yaml
perl -i -pe"s/$MY_CLUSTER_IP/_IP_/g" srcs/metallb-conf.yaml

#--Nginx--
docker build srcs/nginx -t ft_nginx --build-arg clusterIP=$MY_CLUSTER_IP
kubectl apply -f srcs/nginx/nginx.yaml

#--MySQL--
docker build srcs/mysql/ -t ft_mysql
kubectl apply -f srcs/mysql/mysql.yaml

#--PhpMyAdmin--
docker build srcs/phpmyadmin/ -t ft_phpmyadmin --build-arg clusterIP=$MY_CLUSTER_IP
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml

# #--InfluxDB--
kubectl create configmap cert-conf --from-file=$DOCKER_CERT_PATH
docker build srcs/influxdb/ -t ft_influxdb --build-arg dockerHost=$DOCKER_HOST
kubectl apply -f srcs/influxdb/influxdb.yaml

# #--Grafana--
docker build srcs/grafana/ -t ft_grafana
kubectl apply -f srcs/grafana/grafana.yaml

#--Wordpress--
docker build srcs/wordpress/ -t ft_wordpress --build-arg clusterIP=$MY_CLUSTER_IP
kubectl apply -f srcs/wordpress/wordpress.yaml

#--Ftps--
docker build srcs/ftps -t ft_ftps --build-arg clusterIP=$MY_CLUSTER_IP
kubectl apply -f srcs/ftps/ftps.yaml

echo "
----------logins------------
[wp admin]	= nini:nini
[wp user1]	= user1:nini
[wp user2]	= user2:nini
[wp DB]		= wp_user:nini
----------------------------
[grafanaDB] = gra_user:nini
[grafanaU]  = admin:admin
----------------------------
[ftps]		= admin:admin
----------------------------

Minikube ip: $MY_CLUSTER_IP

http://$MY_CLUSTER_IP

"

minikube dashboard