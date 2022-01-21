#Allow remote connection/control on db
sed -i "s/skip-networking/#skip-networking/g" etc/my.cnf.d/mariadb-server.cnf

#install db, persistence and start :
mkdir './data'
/usr/bin/mysql_install_db --datadir="/data" --user=mysql

./install_db.sh &

/usr/bin/mysqld_safe --user='root' --datadir='/data'