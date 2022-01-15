FROM alpine:3.12

RUN apk update \
 && apk add nginx \
 && apk add openssh \
 && apk add openrc \
 && apk add openssl \
 && apk add lftp

COPY ./default.conf /etc/nginx/conf.d/
COPY start.sh .

EXPOSE 22 80 443

CMD ["sh", "start.sh"]