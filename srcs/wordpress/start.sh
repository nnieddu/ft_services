#!/bin/sh

#create nginx folder and give him rights :
mkdir -p /usr/share/nginx/html
mkdir -p /run/nginx
chown -R nginx:nginx /usr/share/nginx/html
chmod 755 /usr/share/nginx/html
chmod 755 /usr/share/nginx/html/wordpress

#create ssl certs and key :
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj '/C=FR/ST=FR/L=null/O=null/CN=null' \
-keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

#download wordpress and wordpress cli :
curl -O https://wordpress.org/wordpress-5.8.3.tar.gz
tar -xf wordpress-5.8.3.tar.gz
rm -rf wordpress-5.8.3.tar.gz
mv wordpress/ /usr/share/nginx/html/

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp-cli

#config wp db :
wp-cli config create --dbhost=10.96.83.102 --dbname=wp_db --dbuser=wp_user --dbpass='nini' --path=/usr/share/nginx/html/wordpress --allow-root
#create users :
wp-cli core install --url=_IP_:5050 --title=nini-wp --admin_user=nini --admin_password=nini --admin_email=ninieddu@student.42lyon.fr --path=/usr/share/nginx/html/wordpress --allow-root
wp-cli user create user1 user1@example.com --user_pass=nini --role=author --path=/usr/share/nginx/html/wordpress --allow-root
wp-cli user create user2 user2@example.com --user_pass=nini --path=/usr/share/nginx/html/wordpress --allow-root

#start php and nginx :
/usr/sbin/php-fpm7
nginx -g 'daemon off;'