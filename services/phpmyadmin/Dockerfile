FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session phpmyadmin

COPY config.inc.php /etc/phpmyadmin/config.inc.php

EXPOSE 5000

CMD ["php","-S", "0.0.0.0:5000", "-t", "/usr/share/webapps/phpmyadmin"]