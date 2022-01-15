mv mariadb.cnf etc/my.cnf.d/mariadb-server.cnf
#install db
#/usr/bin/mysql_install_db --datadir="/var/lib/mysql" --user=mysql
#start
#CREATE DATABASE hadb;
#CREATE USER 'ha' IDENTIFIED BY 'some_password';
#GRANT ALL PRIVILEGES ON hadb.* TO 'ha';
#FLUSH PRIVILEGES;
/usr/bin/mysql_install_db --datadir="/data" --user=mysql
./install_db.sh &
/usr/bin/mysqld_safe --user='root' --datadir='/data' 


#need

#docker exec -it _id_ mysql -u root
#now you can connect with
#mysql -u ha--host='' --port="ports" -p 
