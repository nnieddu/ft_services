FROM alpine:3.12

RUN apk update
RUN apk upgrade
RUN apk add grafana --repository='http://dl-cdn.alpinelinux.org/alpine/latest-stable/community/'

COPY ./start.sh .
COPY ./dashboards/* /var/lib/grafana/dashboards/
COPY ./datasource.yaml /usr/share/grafana/conf/provisioning/datasources
COPY ./dash.yaml /usr/share/grafana/conf/provisioning/dashboards
COPY ./grafana.ini .

EXPOSE 3000


CMD ["sh", "start.sh"]