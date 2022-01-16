#!/bin/sh

mkdir -p /usr/share/nginx/html
mkdir -p /run/nginx

curl -O https://wordpress.org/wordpress-5.8.3.tar.gz
tar -xf wordpress-5.8.3.tar.gz

mysqladmin -u wp_user -h 10.96.83.102 --password='nini' status;
while [ $? != 0 ]
do
	sleep 5;
	mysqladmin -u wp_user -h 10.96.83.102 --password='nini' status;
done
	
if ! ( wp-cli core is-installed --path=/usr/share/nginx/html/wordpress )
then
wp-cli core install --url=_IP_:5050 --title=nini-wp --admin_user=nini --admin_password=nini --admin_email=ninieddu@student.42lyon.fr --path=/usr/share/nginx/html/wordpress
wp-cli option update comment_whitelist 0 --path=/usr/share/nginx/html/wordpress
wp-cli option update comments_notify 0 --path=/usr/share/nginx/html/wordpress
wp-cli user create user1 one@example.com --user_pass=nini --role=author --path=/usr/share/nginx/html/wordpress
wp-cli user create user2 two@example.com --user_pass=nini --path=/usr/share/nginx/html/wordpress
fi

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj '/C=FR/ST=FR/L=null/O=null/CN=null' \
-keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp-cli

mv wordpress/ /usr/share/nginx/html/
wp-cli config create --dbhost=10.96.83.102 --dbname=wp_db --dbuser=wp_user --dbpass='nini' --path=/usr/share/nginx/html/wordpress
chown -R nginx:nginx /usr/share/nginx/html
chmod 755 /usr/share/nginx/html
chmod 755 /usr/share/nginx/html/wordpress

/usr/sbin/php-fpm7
sh install_wp.sh

nginx -g 'daemon off;'