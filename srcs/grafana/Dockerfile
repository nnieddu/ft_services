FROM alpine:3.12

RUN apk update 
RUN apk upgrade 
RUN apk add grafana --repository='http://dl-cdn.alpinelinux.org/alpine/latest-stable/community/'

RUN mkdir -p /usr/share/grafana/conf/provisioning/datasources
RUN mkdir -p /usr/share/grafana/conf/provisioning/dashboards
RUN mkdir -p /var/lib/grafana/dashboards

EXPOSE 3000

COPY ./dashboards/* /var/lib/grafana/dashboards/
COPY ./datasource.yaml /usr/share/grafana/conf/provisioning/datasources
COPY ./dash.yaml /usr/share/grafana/conf/provisioning/dashboards
COPY ./grafana.ini .

COPY ./start.sh .

CMD ["sh", "start.sh"]