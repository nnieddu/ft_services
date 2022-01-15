openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj '/C=FR/ST=FR/L=null/O=null/CN=null' \
-keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

mv /usr/share/webapps/phpmyadmin /usr/share/nginx/html

mkdir /usr/share/nginx/html/phpmyadmin/tmp
mv config.inc.php /usr/share/nginx/html/phpmyadmin
chown -R nginx:nginx /usr/share/nginx/html/phpmyadmin
chmod 755 /usr/share/nginx/html/phpmyadmin
chmod 755 /usr/share/nginx/html/phpmyadmin/tmp

/usr/sbin/php-fpm7
nginx -g 'daemon off;'