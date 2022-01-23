#!/bin/sh

mkdir -p /usr/share/nginx/html
mkdir -p /run/nginx 

mv /usr/share/webapps/phpmyadmin /usr/share/nginx/html
sed -i "s/_IP_/$MYSQL_SERVICE_SERVICE_HOST/g" config.inc.php
mv config.inc.php /usr/share/nginx/html/phpmyadmin

mkdir /usr/share/nginx/html/phpmyadmin/tmp
chmod 777 /usr/share/nginx/html/phpmyadmin/tmp

#ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj '/C=FR/ST=FR/L=null/O=null/CN=null' \
-keyout /etc/ssl/certs/pma.key -out /etc/ssl/certs/pma.crt

#start php and nginx :
/usr/sbin/php-fpm7
nginx -g 'daemon off;'
