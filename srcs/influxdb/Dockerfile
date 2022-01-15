FROM alpine:3.12

COPY ./config.conf .
COPY ./influx.conf .

RUN apk update 
RUN apk add wget
RUN apk add influxdb
RUN apk add telegraf --repository='http://dl-cdn.alpinelinux.org/alpine/latest-stable/community/'
RUN mkdir './data'
RUN mkdir './certs'


COPY ./start.sh .
EXPOSE 8086
CMD ["sh", "start.sh"]
