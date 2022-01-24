FROM alpine:3.12

ARG clusterIP

RUN apk update 
RUN apk upgrade 
RUN apk add nginx openssh openssl lftp

COPY ./default.conf /etc/nginx/conf.d/
COPY ./start.sh .

EXPOSE 80 443

RUN sed -i "s/_IP_/$clusterIP/g" /etc/nginx/conf.d/default.conf

CMD ["sh", "start.sh"]
