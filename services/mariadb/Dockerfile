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

EXPOSE	3306

CMD	["sh", "setup.sh"]
