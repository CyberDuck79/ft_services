until mysql
do
	sleep 0.5
done
sed -i "s/DB_USER/"$DB_USER"/g" create_db.sql
sed -i "s/DB_PASSWORD/"$DB_PASSWORD"/g" create_db.sql
mysql < create_db.sql
#mysql wordpress < wordpress.sql