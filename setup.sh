#!/bin/bash

# export MINIKUBE_HOME=~/goinfre

minikube start --driver=virtualbox --extra-config=apiserver.service-node-port-range=1-6000

export MINIKUBE_IP=$(minikube ip)

#--set config files and docker env--
sed -i "s/_IP_/$MINIKUBE_IP/g" srcs/metallb-conf.yaml
sed -i "s/_IP_/$MINIKUBE_IP/g" srcs/ftps/vsftpd.conf
sed -i "s/_IP_/$MINIKUBE_IP/g" srcs/nginx/default.conf
sed -i "s/_IP_/$MINIKUBE_IP/g" srcs/phpMyAdmin/default.conf
sed -i "s/_IP_/$MINIKUBE_IP/g" srcs/wordpress/default.conf
sed -i "s/_IP_/$MINIKUBE_IP/g" srcs/wordpress/start.sh

eval $(minikube docker-env)

#--Metallb--
minikube addons enable metallb
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb-conf.yaml

#--Ftps--
docker build srcs/ftps -t ft_ftps
kubectl apply -f srcs/ftps/ftps.yaml

#--Nginx--
docker build srcs/nginx -t ft_nginx
kubectl apply -f srcs/nginx/nginx.yaml

#--MySQL--
docker build srcs/mysql/ -t ft_mysql
kubectl apply -f srcs/mysql/mysql.yaml

#--PhpMyAdmin--
docker build srcs/phpMyAdmin/ -t ft_phpmyadmin
kubectl apply -f srcs/phpMyAdmin/phpMyAdmin.yaml

#--InfluxDB--
kubectl create configmap cert-conf --from-file=$DOCKER_CERT_PATH
sed -i "s=_IP_=$DOCKER_HOST=g" srcs/influxdb/config.conf

docker build srcs/influxdb/ -t ft_influxdb
kubectl apply -f srcs/influxdb/influxdb.yaml

#--Wordpress--
docker build srcs/wordpress/ -t ft_wordpress
kubectl apply -f srcs/wordpress/wordpress.yaml

#--Grafana--
docker build srcs/grafana/ -t ft_grafana
kubectl apply -f srcs/grafana/grafana.yaml

#--Reset config files--
sed -i "s/$MINIKUBE_IP/_IP_/g" srcs/metallb-conf.yaml
sed -i "s/$MINIKUBE_IP/_IP_/g" srcs/ftps/vsftpd.conf
sed -i "s/$MINIKUBE_IP/_IP_/g" srcs/nginx/default.conf
sed -i "s/$MINIKUBE_IP/_IP_/g" srcs/phpMyAdmin/default.conf
sed -i "s/$MINIKUBE_IP/_IP_/g" srcs/wordpress/default.conf
sed -i "s/$MINIKUBE_IP/_IP_/g" srcs/wordpress/start.sh
sed -i "s=$DOCKER_HOST=_IP_=g" srcs/influxdb/config.conf

echo "
********logins********

[wp admin]	= nini:nini
[wp user1]	= user1:nini
[wp user2]	= user2:nini
[wp DB]		= wp_user:nini
---------------------------
[grafanaDB] = gra_user:nini
[grafanaU]  = admin:admin
---------------------------
[ftps]		= admin:admin
---------------------------
[ssh]		= root:root

Minikube ip: $MINIKUBE_IP

"

minikube dashboard