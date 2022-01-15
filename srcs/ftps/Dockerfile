FROM alpine:3.12

RUN apk update
RUN apk add vsftpd
RUN apk add openssl
RUN mkdir /var/ftp/

COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./start.sh .

EXPOSE 21

CMD ["sh", "start.sh"]
