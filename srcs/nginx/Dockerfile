FROM alpine:3.12

RUN apk update
RUN apk upgrade
RUN apk add nginx openssh openssl lftp

COPY ./default.conf /etc/nginx/conf.d/
COPY ./start.sh .

EXPOSE 22 80 443

CMD ["sh", "start.sh"]