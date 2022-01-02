# ft_services 42

Le projet consiste à mettre en place une infrastructure de différents services, avec ses propres règles.\n
Chaque service doit tourner dans un container dédié.
Chaque container doit obligatoirement porter le même nom que le service concerné.
Pour des raisons de performances, les containers doivent être build sous Alpine Linux.
Aussi, ils possédent tous un Dockerfile sera appelé dans le setup.sh.

Infrastructure et différents services à mettre en place :

• Le dashboard web de Kubernetes. Celui-ci est utile pour gérer votre cluster.

• Un Load Balancer qui gère l’accès externe à nos services dans un cluster.
C’est uniquement lui qui servira pour exposer nos services. 
Nous devons garder les ports propres aux services (IP :3000 pour Grafana etc). 
Le Load Balancer n’utilise qu’une seule ip.

• Un WordPress ouvert sur le port 5050, fonctionnant avec une base de données MySQL. 
Les deux devront être dans deux containers distincts.

Le WordPress comporte plusieurs utilisateurs et un administrateur (pour tester que tous fonctionne bien).
WordPress aura son propre serveur nginx.
Le Load Balancer devra donc pouvoir directement rediriger sur ce service.

• phpMyAdmin, tournant sur le port 5000 et relié à la base de données MySQL.
PhpMyAdmin aura son propre serveur nginx. 
Le Load Balancer devra donc pouvoir directement rediriger sur ce service.

• Un container contenant un serveur nginx ouvert sur les ports 80 et 443. 
Le port 80 sera en http et devra faire une redirection systématique de type 301 vers le 443, qui sera lui en https.
La page affichée n’a pas d’importance, tant que ce n’est pas une erreur http.
Ce container dera permettre d’accéder à une route /wordpress qui fait un redirect 307 vers IP :WPPORT.
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

Voici un schéma exemple de ce que vous devrez mettre en place :

![shema](https://github.com/nnieddu/ft_services/blob/main/shema.png)

/!\ L’utilisation de services de type Node Port, de l’objet Ingress
Controller ou de la commande kubectl port-forward est interdite.
Votre Load Balancer doit être le seul point d’entrée du Cluster.

```
function test() {
  console.log("notice the blank line before this function?");
}
```
## Kubernetes Infos & CheatSheet
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
Data from ConfigMap or Secret services can be used inside the app pod to use it for ex for environement variables or propreties files.

Volumes component : serve to store the data persistent between restart of services (can be local or external / cloud).

Deployement component : it's a blueprints for pods, where you can specify the number of app pods replica you want and her configuration.
=> CAN NOT BE USED FOR DB

StatefulSet component : 


## K8s Commands :
### minikube CLI

######Start minikube :
```
minikube start --driver=<driver_name>
```
*in our case we gonna choose virtual box hypervisor to run minikube who need an hypervisor. (minikube start --driver=virtualbox)

```
minikube kubectl get nodes
```

Display the status of minikube
```
minikube status
```
### kubectl CLI
