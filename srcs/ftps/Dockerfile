FROM alpine:latest

RUN apk update \
    && apk add --no-cache vsftpd openssl curl

RUN	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=78/L=Poissy/O=42/CN=fhenrion' -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY start.sh start.sh
COPY livenessprobe.sh livenessprobe.sh

EXPOSE 20 21 21000-21010

CMD	["sh", "start.sh"]