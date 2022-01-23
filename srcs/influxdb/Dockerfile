FROM alpine:3.12

ARG dockerHost 

RUN apk update 
RUN apk upgrade 
RUN apk add wget influxdb telegraf --repository='http://dl-cdn.alpinelinux.org/alpine/latest-stable/community/'

COPY ./telegraf.conf .
COPY ./influx.conf .
COPY ./start.sh .

RUN sed -i "s=_IP_=$dockerHost=g" telegraf.conf

EXPOSE 8086

CMD ["sh", "start.sh"]