#!/bin/sh

sed -i "s/_IP_/$1/g" /etc/nginx/conf.d/default.conf

mkdir -p /usr/share/nginx/html
mkdir -p /run/nginx

chown -R nginx:nginx /usr/share/nginx/html
chmod 744 /usr/share/nginx/html

#Pour autoriser/tester le serveur ftps avec un certif autosigne :
echo "set ssl:verify-certificate off" >> /etc/lftp.conf

# Page acceuil html simple :
echo "<h1><center>ft_services 42 by ninieddu </center></h1>" > /usr/share/nginx/html/index.html
echo "<p>You can use /phpmyadmin</p>" >> /usr/share/nginx/html/index.html
echo "or" >> /usr/share/nginx/html/index.html
echo "<p>You can use /wordpress</p>" >> /usr/share/nginx/html/index.html

# #ssh :
# echo "root:root" | chpasswd
# sed -i "s/#Port 22/Port 22/g" /etc/ssh/sshd_config
# sed -i "s/#PermitRootLogin.*/PermitRootLogin\ yes/" /etc/ssh/sshd_config
# sed -i "s/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g" /etc/ssh/sshd_config

# /usr/bin/ssh-keygen -A
# ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_key

#ssl :
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj '/C=FR/ST=FR/L=null/O=null/CN=null' \
-keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

#clean
rm start.sh