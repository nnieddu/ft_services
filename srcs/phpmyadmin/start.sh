#!/bin/sh

mkdir -p /usr/share/nginx/html
mkdir -p /run/nginx 

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj '/C=FR/ST=FR/L=null/O=null/CN=null' \
-keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

mv /usr/share/webapps/phpmyadmin /usr/share/nginx/html
mv config.inc.php /usr/share/nginx/html/phpmyadmin

mkdir /usr/share/nginx/html/phpmyadmin/tmp
chown -R nginx:nginx /usr/share/nginx/html/phpmyadmin
chown -R nginx:nginx /usr/share/nginx/html/phpmyadmin/tmp
chmod 755 /usr/share/nginx/html/phpmyadmin
chmod 777 /usr/share/nginx/html/phpmyadmin/tmp

#start php and nginx :
/usr/sbin/php-fpm7
nginx -g 'daemon off;'

#clean
rm start.sh #!!
