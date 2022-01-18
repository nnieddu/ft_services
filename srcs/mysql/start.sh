mv mariadb.cnf etc/my.cnf.d/mariadb-server.cnf

mkdir './data'
/usr/bin/mysql_install_db --datadir="/data" --user=mysql
./install_db.sh &
/usr/bin/mysqld_safe --user='root' --datadir='/data'