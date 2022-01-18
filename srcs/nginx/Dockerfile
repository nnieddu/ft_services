FROM alpine:3.12

ARG clusterIP

RUN apk update
RUN apk add nginx openssh openssl lftp

RUN mkdir -p /usr/share/nginx/html
RUN mkdir -p /run/nginx

#Page demo html simple :
RUN echo "<h1><center>ft_services 42 by ninieddu </center></h1> \
<p>You can use /phpmyadmin</p> \
or \
<p>You can use /wordpress</p>" > /usr/share/nginx/html/index.html

#Pour autoriser/tester le serveur ftps avec un certif autosigne :
RUN echo "set ssl:verify-certificate off" >> /etc/lftp.conf

COPY ./default.conf /etc/nginx/conf.d/
COPY ./start.sh .

RUN sed -i "s/_IP_/$clusterIP/g" /etc/nginx/conf.d/default.conf

RUN sh start.sh

EXPOSE 22 80 443

CMD ["nginx", "-g", "daemon off;"]