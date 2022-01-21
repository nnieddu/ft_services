# ft_services 42 (README WIP)

Le projet consiste à mettre en place une infrastructure de différents services, avec ses propres règles.\n
Chaque service doit tourner dans un container dédié.
Chaque container doit obligatoirement porter le même nom que le service concerné.
Pour des raisons de performances, les containers doivent être build sous Alpine Linux.
Aussi, ils possédent tous un Dockerfile aui seront build et appelés dans le setup.sh.

Infrastructure et différents services à mettre en place :

• Le dashboard web de Kubernetes. Celui-ci est utile pour gérer votre cluster.

• Un Load Balancer (matallb) qui gère l’accès externe à nos services dans un cluster.
C’est uniquement lui qui servira pour exposer nos services. 
Nous devons garder les ports propres aux services (IP :3000 pour Grafana etc). 
Le Load Balancer n’utilise qu’une seule ip.

• Un WordPress ouvert sur le port 5050, fonctionnant avec une base de données MySQL. 
Les deux devront être dans deux containers distincts.
Le WordPress comporte plusieurs utilisateurs et un administrateur (pour tester que tous fonctionne bien).
WordPress a son propre serveur nginx.
Le Load Balancer devra donc pouvoir directement rediriger sur ce service.

• phpMyAdmin, tournant sur le port 5000 et relié à la base de données MySQL.
PhpMyAdmin a son propre serveur nginx. 
Le Load Balancer devra donc pouvoir directement rediriger sur ce service.

• Un container avec un serveur nginx ouvert sur les ports 80 et 443. 
Le port 80 sera en http et devra faire une redirection systématique de type 301 vers le 443, qui sera lui en https.
La page affichée n’a pas d’importance, tant que ce n’est pas une erreur http.
Ce container permet d’accéder à une route /wordpress qui fait un redirect 307 vers IP :WPPORT.
Il devra aussi permettre d’accéder à /phpmyadmin avec un reverse proxy vers IP :PMAPORT.
 
• Un serveur FTPS ouvert sur le port 21. 

• Un Grafana, accessible sur le port 3000, fonctionnant avec une base de données InfluxDB. 
Celui-ci devra vous permettre de monitorer tous vos containers. 
Les deux devront aussi être dans deux containers distincts. 
Vous devrez créer un dashboard par container.

• En cas de crash ou d’arrêt d’un des deux containers de base de données, vous
devrez vous assurer que celles-ci puissent persister et ne soient pas perdues. 
En cas de suppression, les volumes où la data est sauvegardée doivent persister.

• Chacun de vos containers devra pouvoir redémarrer automatiquement en cas de
crash ou d’arrêt d’un des éléments le composant.

Assurez vous que les redirections vers les différents services se sont bien via un load balancer. 
FTPS, Grafana et Nginx, phpMyAdmin et Wordpress doivent etre du type "LoadBalancer". 
Influxdb et Mysql devront être de type "ClusterIP". D’autres entrées
peuvent être présente, mais aucune ne doit etre du type "NodePort".

Voici un schéma exemple de ce qui est mis en place :

![shema](https://github.com/nnieddu/my_services/blob/main/shema.png)

/!\ L’utilisation de services de type Node Port, de l’objet Ingress
Controller ou de la commande kubectl port-forward est interdite pour le sujet de cet exercice.
Le Load Balancer doit être le seul point d’entrée du Cluster.

Pour le bon fonctionnement de ssh et ftps d'autres ports doivent etre utilises.

## Links :
Alpine :
https://wiki.alpinelinux.org/wiki/Enable_Community_Repository

minikube bases, start, images building and usage on local :
https://minikube.sigs.k8s.io/docs/start/
https://minikube.sigs.k8s.io/docs/drivers/virtualbox/
https://minikube.sigs.k8s.io/docs/handbook/accessing/
https://minikube.sigs.k8s.io/docs/handbook/pushing/
https://minikube.sigs.k8s.io/docs/commands/docker-env/
https://minikube.sigs.k8s.io/docs/handbook/persistent_volumes/

metallb & nginx :

Useless if use of metallb addon : https://metallb.universe.tf/installation/#installation-by-manifest
https://devopslearning.medium.com/metallb-load-balancer-for-bare-metal-kubernetes-43686aa0724f
https://medium.com/@shoaib_masood/metallb-network-loadbalancer-minikube-335d846dfdbe
https://openclassrooms.com/fr/courses/1733551-gerez-votre-serveur-linux-et-ses-services/5236081-mettez-en-place-un-reverse-proxy-avec-nginx
Good security post on nginx (with k8s) : https://bridgecrew.io/blog/creating-a-secure-kubernetes-nginx-deployment-using-checkov/ 

mysql / mariaDB:
https://dev.mysql.com/doc/refman/5.7/en/connecting.html
https://mariadb.com/kb/en/mysqld_safe/

phpmyadmin :
https://docs.phpmyadmin.net/fr/latest/
hide useless dbs : https://stackoverflow.com/questions/12071460/how-to-hide-information-schema-database-from-phpmyadmin

Grafana :
https://grafana.com/docs/grafana/latest/introduction/
https://grafana.com/grafana/dashboards/

Influxdb :
https://docs.influxdata.com/influxdb/v2.1/

Ftps (vsftpd) :
https://wiki.alpinelinux.org/wiki/FTP
http://vsftpd.beasts.org/vsftpd_conf.html
https://www.liquidweb.com/kb/configure-vsftpd-ssl/
https://web.mit.edu/rhel-doc/5/RHEL-5-manual/Deployment_Guide-en-US/s1-ftp-vsftpd-conf.html

wordpress & Mysql alpine : 
https://wiki.alpinelinux.org/wiki/WordPress
https://wp-cli.org/

## Kubernetes Infos & CheatSheet

What is Minikube?
Minikube is a tool that makes it easy to run Kubernetes locally. Minikube runs a single-node Kubernetes cluster inside a VM on your laptop for users looking to try out Kubernetes or develop with it day-to-day.

Kubernetes is an open source conatainers orchestror originaly develloped by Google.
His goal is to help manage containerized applications, in different deployement environments.
Kubernetes permit a high availability (no downtime), disaster recovery (fast backup and restore) and scalability.

K8s comonents :
*NODE :* who can contain : Pods (k8s container, usually 1 application/service per pod).

K8s Communication : each pod gets its own Ip adress who change if pod restart/crash.
*Service* = permanent Ip adress, even if the pod crash, the service will not change, we can connect multiple pods to the same service to have a duplica
of our application and so if an app pod crash, the app would still be accessible for users.
External or Internal service (external are open to public request on the internet)
Service is load balancer too, the least busy pod/server is gonna be choose by service. 

App should be accessible trough browser : Ingress (make the service accessible trough domain name instead of ip adresse:port).

*ConfigMap :* avoid rebuild image and restart service if you want for ex change the db url/service/name
*Secret :* this component is like ConfigMap but is used to store secret data (base4 encoded) ex = DB_USER = mongo-user or DB_PWD = mongo-pwd
because it's not secure to store/share credentials or sensitive informations in ConfigMap.
Data from ConfigMap or Secret services can be used inside the app pod to use it for environement variables or propreties files for ex.

Volumes component : serve to store the data persistent between restart of services (can be local or external / cloud).

Deployement component : it's a blueprints for pods, where you can specify the number of app pods replica you want and her configuration.  
=> Do not use Deployement for DB !

For DB :
StatefulSet component : 
Stateless component :


MetalLB is a load-balancer implementation for bare metal Kubernetes clusters, using standard routing protocols.
Exposes the service externally using a cloud provider loadbalancer. Node-port and Cluster-IP services to which the external loadbalancer routes, are automatically created in k8s. There is a big problem occurs as the type LoadBalancer is only available for use if your K8s cluster is setup in any of the public cloud providers, GCE AWS , etc which ar not free... that's why we use Metallb.

## Rapid and important tips : 
*Régler imagePullPolicysur Never, sinon Kubernetes essaiera de télécharger l'image (dans les deployements .yaml).

*Vous devez exécuter eval $(minikube docker-env) sur chaque terminal ou vous souhaitez utiliser des commandes 'docker', car il définit uniquement les variables d'environnement pour la session shell actuelle.

## K8s Commands
### minikube CLI :

###### Start minikube :
```
minikube start --driver=<driver_name>
```
*in our case we gonna choose virtual box hypervisor to run minikube who need an hypervisor. (minikube start --driver=virtualbox)

```
minikube stop
```

```
minikube kubectl get nodes
```

Display the status of minikube :
```
minikube status
```
Open desired service in web browser :
```
minikube service <service name>
```

Getting the NodePort :
```
minikube service --url <service name>
```
```
minikube dashboard
```

### kubectl CLI
(if you install minikube only, you will need to add "minikube " before commands)
```
kubectl get nodes
```

```
kubectl get pod
```


```
kubectl create -h
```
```
kubectl create deployment nginx-depl --image=nginx
```

```
kubectl get deployment
```

```
kubectl get replicaset
```

```
kubectl edit deployment <name of pod>
```

```
kubectl delete deployment <name of pod>
```
-f for file
```
kubectl apply -f <config-file.yaml>
```
Debug : 
```
kubectl logs <name of pod>
```
Exec un terminal -it = interactif dans le pod
```
kubectl exec -it <pod name> -- bin/bash
```
```
kubectl rollout restart deploy DEPLOYEMENT
```

 By default, minikube only exposes/use Nodeport 30000-32767.

`minikube docker - env | Invoke - Expression` # PowerShell windows

minikube start vm-driver=hyperkit #Start minikube with hyperkit, The best for macOS apparently

kubectl get events 

#Dashboard
minikube dashboard

# Kubectl usefull cmds

kubectl get all
kubectl logs deployment/DEPLOYMENT

kubectl exec -it POD_NAME -- bin/sh
=> ./fast.sh DEPLOYMENT

kubectl rollout restart deploy DEPLOYMENT

kubectl delete deployment DEPLOYMENT

#FTPS
lftp _IP_
login admin admin

#minikube start --extra-config=kubelet.authentication-token-webhook=true is used to enable
# API bearer tokens to authenticate to the kubelet's HTTPS endpoint
# --host-only-cidr works only with virtualbox driver + safari make things worse
# delete to use default host cidr (192.168.99.1/24) if anything goes wrong
