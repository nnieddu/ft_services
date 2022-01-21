mysqladmin status;

while [ $? != 0 ]
do	
	sleep 5;
	mysqladmin status;
done

mysql < db_wordpress.sql
mysql < db_grafana.sql