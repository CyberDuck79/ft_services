FROM	alpine:latest

RUN	echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update \
	&& apk add --no-cache telegraf@testing

COPY telegraf.conf /etc/telegraf.conf

EXPOSE	8125

CMD	["telegraf", "--config", "/etc/telegraf.conf"]