FROM alpine:3.12

COPY ./config.conf .
COPY ./influx.conf .

RUN apk update 
RUN apk upgrade 
RUN apk add wget influxdb telegraf --repository='http://dl-cdn.alpinelinux.org/alpine/latest-stable/community/'

COPY ./start.sh .

EXPOSE 8086

CMD ["sh", "start.sh"]
