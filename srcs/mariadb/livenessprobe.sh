if mysqladmin ping --password=$MYSQL_ROOT_PASSWORD > /dev/null
then
    exit 0
else
    exit 1
fi