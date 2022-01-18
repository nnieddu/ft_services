FROM alpine:3.12

RUN apk update
RUN apk upgrade
RUN apk add mariadb mariadb-client wget

COPY ./gra.sql .
COPY ./wp.sql .
COPY ./mariadb.cnf .
COPY ./install_db.sh .
COPY ./start.sh .

EXPOSE 3306

CMD ["sh", "start.sh"]