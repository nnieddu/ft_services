#!/bin/bash

# export MINIKUBE_HOME=~/goinfre

minikube start --driver=virtualbox --extra-config=apiserver.service-node-port-range=1-6000

minikube addons enable metallb

eval $(minikube docker-env)

export MINIKUBE_IP=$(minikube ip)

sed "s/_IP_/$MINIKUBE_IP/g" srcs/metallb/sample > srcs/metallb/metallb-conf.yaml
sed "s/_IP_/$MINIKUBE_IP/g" srcs/ftps/sample > srcs/ftps/vsftpd.conf
sed "s/_IP_/$MINIKUBE_IP/g" srcs/nginx/sample > srcs/nginx/default.conf
sed "s/_IP_/$MINIKUBE_IP/g" srcs/phpMyAdmin/sample > srcs/phpMyAdmin/default.conf
sed "s/_IP_/$MINIKUBE_IP/g" srcs/wordpress/sample > srcs/wordpress/default.conf
sed "s/_IP_/$MINIKUBE_IP/g" srcs/wordpress/install > srcs/wordpress/install_wp.sh

#--metallb--
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" # creating secretkey to encrypt the communication between speakers for the fast dead node detection
kubectl apply -f srcs/metallb/metallb-conf.yaml

#--ftps--
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
sed "s=_IP_=$DOCKER_HOST=g" srcs/influxdb/sample > srcs/influxdb/config.conf
docker build srcs/influxdb/ -t ft_influxdb
kubectl apply -f srcs/influxdb/influxdb.yaml

#--Wordpress--
docker build srcs/wordpress/ -t ft_wordpress
kubectl apply -f srcs/wordpress/wordpress.yaml

#--grafana--
docker build srcs/grafana/ -t ft_grafana
kubectl apply -f srcs/grafana/grafana.yaml

minikube dashboard