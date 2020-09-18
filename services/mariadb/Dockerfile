FROM alpine:latest


RUN	apk update && apk upgrade
RUN	apk add mariadb mariadb-client

COPY create_db.sql .
COPY wordpress.sql .
COPY setup.sh .
COPY start_mysql.sh .
COPY import_db.sh .
COPY livenessprobe.sh livenessprobe.sh

RUN	chmod 755 setup.sh start_mysql.sh import_db.sh create_db.sql
RUN sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
RUN /usr/bin/mysql_install_db --user=mysql --datadir="/var/lib/mysql"

EXPOSE	3306

CMD	["sh", "setup.sh"]
