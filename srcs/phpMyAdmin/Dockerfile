FROM alpine:3.12

RUN apk update
RUN apk add nginx
RUN apk add openssl
RUN apk add php7 php7-fpm php7-opcache php7-json
RUN apk add php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
RUN apk add mysql mysql-client php-mysqli php7-session
RUN apk add wget
RUN apk add php-mbstring
RUN apk add phpmyadmin
RUN mkdir -p /usr/share/nginx/html
RUN mkdir -p /run/nginx 

COPY ./default.conf /etc/nginx/conf.d/
COPY ./config.inc.php .
COPY ./start.sh .

EXPOSE 5000

CMD ["sh", "start.sh"]