FROM alpine:3.12

ARG clusterIP

RUN apk update
RUN apk add nginx openssh openssl lftp

COPY ./default.conf /etc/nginx/conf.d/
COPY ./daemons.sh .
COPY ./start.sh .

EXPOSE 22 80 443

RUN sh start.sh $clusterIP

# CMD ["nginx", "-g", "daemon off;"]
CMD ["sh", "daemons.sh"]