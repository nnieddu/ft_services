FROM alpine:3.12

RUN apk update
RUN apk upgrade 
RUN apk add vsftpd openssl

COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./start.sh .

EXPOSE 21

CMD ["sh", "start.sh"]