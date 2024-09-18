FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx \
	&& apt-get clean \
	&& apt-get install vim -y \
	&& apt-get install curl -y \
	&& mkdir -p /etc/nginx/ssl 

RUN apt-get install openssl -y

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=PT/L=Porto/CN=mcarneir.42.fr/UID=mcarneir"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginc/nginx.conf

RUN chmod 755 /var/www/html \
	&& chown -R www-data:www-data /var/www/html

EXPOSE 433

CMD [ "nginx", "-g", "daemon off;" ]

