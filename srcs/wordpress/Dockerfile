FROM alpine:3.12

ARG clusterIP

RUN apk update
RUN apk upgrade
RUN apk add nginx openssl mysql-client curl lighttpd php7 php7-fpm php7-opcache \
php7-openssl php7-zlib php-phar php-iconv php7-common php7-session php7-iconv php7-json \
php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql \
php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype \
php7-dom php7-simplexml

RUN curl -O https://wordpress.org/wordpress-5.8.3.tar.gz
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

COPY ./start.sh .
RUN sed -i "s/_IP_/$clusterIP/g" start.sh

COPY ./default.conf /etc/nginx/conf.d/

EXPOSE 5050

CMD ["sh", "start.sh"]
