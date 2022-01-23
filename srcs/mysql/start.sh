#Allow remote connection/control on db
sed -i "s/skip-networking/#skip-networking/g" etc/my.cnf.d/mariadb-server.cnf

#install db, persistence and start :
/usr/bin/mysql_install_db --datadir="/data" --user=mysql

# mysqladmin status

# while [ $? != 0 ]
# do	
# 	sleep 1
# 	mysqladmin status
# done

# mysql < db_wordpress.sql
# mysql < db_grafana.sql

# mysqladmin status

# while [ $? != 0 ]
# do	
# 	sleep 1
# 	mysqladmin status
# done

./install_db.sh &

/usr/bin/mysqld_safe --user='root' --datadir='/data'