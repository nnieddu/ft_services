FROM alpine:3.12

RUN apk update
RUN apk upgrade
RUN apk add mariadb mariadb-client

COPY ./*.sql ./
COPY start.sh .
COPY install_db.sh .

EXPOSE 3306

CMD ["sh", "start.sh"]