PODNAME=$(kubectl get pods | grep $1 | cut -d ' ' -f 1)
kubectl logs $PODNAME
echo $PODNAME
kubectl exec -it $PODNAME -- bin/sh