FROM alpine:3.12

RUN apk update
RUN apk add nginx
RUN apk add openssl
RUN apk add php7 php7-fpm php7-opcache php7-json
RUN apk add php7-openssl php7-xml php7-pdo php7-mcrypt php7-session php7-mysqli php7-zlib
RUN apk add mysql-client
RUN apk add curl
RUN apk add php-phar
RUN apk add php-iconv
RUN mkdir -p /usr/share/nginx/html
RUN mkdir -p /run/nginx

RUN curl -O https://wordpress.org/wordpress-5.8.3.tar.gz
RUN tar -xf wordpress-5.8.3.tar.gz

COPY ./default.conf /etc/nginx/conf.d/
COPY ./install_wp.sh .
COPY ./start.sh .

EXPOSE 5050
CMD ["sh", "start.sh"]