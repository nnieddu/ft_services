FROM alpine:3.12

RUN apk update
RUN apk upgrade
RUN apk add mariadb mariadb-client wget

COPY ./srcs/* ./

EXPOSE 3306

CMD ["sh", "start.sh"]
