#Create DB :
echo "CREATE DATABASE wp_db;
CREATE USER 'wp_user' IDENTIFIED BY 'nini'; 
GRANT ALL PRIVILEGES ON wp_db.* TO 'wp_user';
FLUSH PRIVILEGES;" > wp.sql

echo "CREATE DATABASE gra_db;
CREATE USER 'gra_user' IDENTIFIED BY 'nini';
GRANT ALL PRIVILEGES ON gra_db.* TO 'gra_user';
FLUSH PRIVILEGES;" > gra.sql

#Allow remote connection/control on db
sed -i "s/skip-networking/#skip-networking/g" etc/my.cnf.d/mariadb-server.cnf

#install db, persistence and start :
mkdir './data'
/usr/bin/mysql_install_db --datadir="/data" --user=mysql

./install_db.sh &

/usr/bin/mysqld_safe --user='root' --datadir='/data'