#!/bin/bash

PODNAME=$(kubectl get pods | grep $1 | cut -d ' ' -f 1)

if [ $2 ]
then
	if [ $2 = "-d" ]
	then
		kubectl delete pod $PODNAME --grace-period=0
		exit
	fi

	if [ $2 = "-l" ]
	then
		kubectl logs $PODNAME
		exit
	fi

	if [ $2 = "-r" ]
	then
		PODNAME=$(echo $PODNAME | cut -d '-' -f 1)
		echo $PODNAME
		kubectl rollout restart deploy $PODNAME
		exit
	fi

	if [ $2 = "-rmrf" ]
	then
		PODNAME=$(echo $PODNAME | cut -d '-' -f 1)
		kubectl exec deploy/$PODNAME -- pkill $PODNAME
		exit
	fi

	if [ $2 = "-a" ] || [ $2 = "-al" ] || [ $2 = "-la" ] 
	then
		if [ $2 = "-al" ] || [ $2 = "-la" ] 
		then
			kubectl logs $PODNAME
		fi
		echo $PODNAME

		kubectl exec -it $PODNAME -- bin/sh
		exit
	fi
fi
echo $PODNAME
kubectl exec -it $PODNAME -- bin/sh
