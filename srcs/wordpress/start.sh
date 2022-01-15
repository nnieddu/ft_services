openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj '/C=FR/ST=FR/L=null/O=null/CN=null' \
-keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp-cli

mv wordpress/ /usr/share/nginx/html/
wp-cli config create --dbhost=10.96.83.102 --dbname=wp_db --dbuser=wp_user --dbpass='1234' --path=/usr/share/nginx/html/wordpress
chown -R nginx:nginx /usr/share/nginx/html
chmod 755 /usr/share/nginx/html
chmod 755 /usr/share/nginx/html/wordpress

/usr/sbin/php-fpm7
sh install_wp.sh
nginx -g 'daemon off;'