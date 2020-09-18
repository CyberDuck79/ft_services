FROM alpine:latest

RUN apk update && apk upgrade
# add bash ???
RUN apk --no-cache add openssh openssl nginx
RUN mkdir -p /run/nginx && rm /etc/nginx/nginx.conf

COPY sshd_config /etc/ssh/sshd_config
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/
COPY index.css /usr/share/nginx/html/
COPY rubber_ducky.jpg /usr/share/nginx/html/
COPY quack.mp3 /usr/share/nginx/html/
COPY start.sh start.sh
COPY livenessprobe.sh livenessprobe.sh

RUN	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=78/L=Poissy/O=42/CN=fhenrion' -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

EXPOSE 80 443 22

CMD ["sh", "start.sh"]