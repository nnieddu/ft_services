mysqladmin status;

while [ $? != 0 ]
do	
	sleep 5;
	mysqladmin status;
done

mysql < wp.sql
mysql < gra.sql
