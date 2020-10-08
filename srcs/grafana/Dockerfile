FROM	alpine:latest

RUN	echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update && apk upgrade \
	&& apk add --no-cache libc6-compat grafana@testing

COPY dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboards.yaml
COPY influxdb.yaml /usr/share//grafana/conf/provisioning/datasources/influxdb.yaml
COPY defaults.ini /usr/share/grafana/conf/defaults.ini
COPY dashboards/ /usr/share/grafana/dashboards

EXPOSE 3000

WORKDIR /usr/share/grafana/conf
CMD	["grafana-server"]