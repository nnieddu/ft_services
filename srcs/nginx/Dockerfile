FROM alpine:3.12

RUN apk update
RUN apk add nginx openssh openssl lftp

COPY ./default.conf /etc/nginx/conf.d/
COPY ./start.sh .

EXPOSE 80 443

RUN sh start.sh

CMD ["nginx", "-g", "daemon off;"]
