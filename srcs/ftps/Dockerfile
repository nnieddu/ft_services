FROM alpine:3.12

ARG clusterIP

RUN apk update
RUN apk upgrade 
RUN apk add vsftpd openssl

COPY ./vsftpd.conf /etc/vsftpd/
COPY ./start.sh .

RUN sed -i "s/_IP_/$clusterIP/g" /etc/vsftpd/vsftpd.conf

EXPOSE 21

RUN sh start.sh

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]