#!/bin/bash

kubectl delete --all deployments
kubectl delete --all pods
kubectl delete --all services
kubectl delete --all secret
kubectl delete --all replicaset
kubectl delete --all configmap
kubectl delete --all namespace

# ssh-keygen -f "/home/douwi/.ssh/known_hosts" -R "$(minikube ip)"

eval $(minikube docker-env)
docker rm -vf $(docker ps -aq)
docker rmi -f $(docker images -aq)
docker system prune -a -f

minikube stops
minikube delete --all --purge

# rm -rf $HOME/.minikube
# rm -rf $HOME/.kube
