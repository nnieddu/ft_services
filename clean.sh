#!/bin/bash

kubectl delete --all deployments
kubectl delete --all pods
kubectl delete --all services
kubectl delete --all pv
kubectl delete --all pvc
kubectl delete --all secret
kubectl delete --all replicaset
kubectl delete --all configmap
kubectl delete --all namespace
minikube stop
minikube delete --all --purge

# rm -rf ~/goinfre/.minikube
eval $(minikube docker-env)

# docker image prune --all --force
docker rm -vf $(docker ps -aq)
docker rmi -f $(docker images -aq)
docker system prune -a -f

# ~$ vboxmanage guestproperty get busybox "/VirtualBox/GuestInfo/Net/0/V4/IP"