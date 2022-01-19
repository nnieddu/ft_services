FROM alpine:3.12

ARG dockerHost 

RUN apk update 
RUN apk upgrade 
RUN apk add wget influxdb telegraf --repository='http://dl-cdn.alpinelinux.org/alpine/latest-stable/community/'

COPY ./config.conf .
COPY ./influx.conf .
COPY ./start.sh .

RUN mkdir './data'
RUN mkdir './certs'

RUN sed -i "s=_IP_=$dockerHost=g" config.conf

EXPOSE 8086

CMD ["sh", "start.sh"]

