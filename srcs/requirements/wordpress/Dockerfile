FROM debian:bullseye

ARG PHPPATH=/etc/php/7.4/fpm

RUN apt-get upgrade && apt-get update -y && apt-get -y install \
	wget \
	curl \
	bash \
	php7.4-fpm \
	php7.4-mysql \
	tar \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

RUN	chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

COPY conf/www.conf ${PHPPATH}/pool.d/

COPY tools/wordpress.sh /usr/local/bin/

RUN  chmod +x /usr/local/bin/wordpress.sh

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/wordpress.sh" ]
CMD ["/usr/sbin/php-fpm7.4", "-F"]
