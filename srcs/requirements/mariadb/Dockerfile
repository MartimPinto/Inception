FROM debian:bullseye


RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server \
	&& apt-get install vim -y \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql \
	&& chown -R mysql:mysql /var/lib/mysql \
	&& chmod 755 /var/lib/mysql

RUN mkdir -p /run/mysqld \
	&& chown -R mysql:mysql /run/mysqld \
	&& chmod 755 /run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/mariadb.sh /bin/
RUN chmod +x /bin/mariadb.sh


EXPOSE 3306

ENTRYPOINT [ "/bin/mariadb.sh"]
CMD ["/usr/bin/mysqld_safe"]
