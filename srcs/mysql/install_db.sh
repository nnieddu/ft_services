echo "CREATE DATABASE wp_db;
CREATE USER 'wp_user' IDENTIFIED BY 'nini'; 
GRANT ALL PRIVILEGES ON wp_db.* TO 'wp_user';
FLUSH PRIVILEGES;" > wp.sql

echo "CREATE DATABASE gra_db;
CREATE USER 'gra_user' IDENTIFIED BY 'nini';
GRANT ALL PRIVILEGES ON gra_db.* TO 'gra_user';
FLUSH PRIVILEGES;" > gra.sql

mysqladmin status;

while [ $? != 0 ]
do	
	sleep 5;
	mysqladmin status;
done

mysql < wp.sql
mysql < gra.sql