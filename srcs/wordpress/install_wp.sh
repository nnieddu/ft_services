mysqladmin -u wp_user -h 10.96.83.102 --password='1234' status;
while [ $? != 0 ]
do
	sleep 5;
	mysqladmin -u wp_user -h 10.96.83.102 --password='1234' status;
done
	
if ! ( wp-cli core is-installed --path=/usr/share/nginx/html/wordpress )
then
wp-cli core install --url=192.168.59.253:5050 --title=nini-wp --admin_user=nini --admin_password=nini --admin_email=ninieddu@student.42lyon.fr --path=/usr/share/nginx/html/wordpress
wp-cli option update comment_whitelist 0 --path=/usr/share/nginx/html/wordpress
wp-cli option update comments_notify 0 --path=/usr/share/nginx/html/wordpress
wp-cli user create user1 one@example.com --user_pass=1234 --role=author --path=/usr/share/nginx/html/wordpress
wp-cli user create user2 two@example.com --user_pass=1234 --path=/usr/share/nginx/html/wordpress
fi
