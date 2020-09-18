FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

RUN	mkdir -p /var/www/wordpress

RUN	wget https://wordpress.org/latest.tar.gz \
	&& tar -xvf latest.tar.gz \
	&& rm -rf latest.tar.gz \
	&& chmod 755 -R /wordpress

COPY wp-config.php /wordpress/wp-config.php

EXPOSE 5050

CMD ["php","-S", "0.0.0.0:5050", "-t", "/wordpress"]

#TODO secrets + deployment + service + create DB DUMP + sed IP in DUMP + verifier IP