FROM debian:bullseye

ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG DB_ROOT_PASS

ENV DB_NAME=${DB_NAME}
ENV DB_USER=${DB_USER}
ENV DB_PWD=${DB_PASS}
ENV DB_PWD_ROOT=${DB_ROOT_PASS}

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server \
	&& apt-get install vim -y \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql \
	&& chown -R mysql:mysql /var/lib/mysql \
	&& chmod -R 755 /var/lib/mysql

RUN mkdir -p /run/mysqld \
	&& chown -R mysql:mysql /run/mysqld \
	&& chmod -R 755 /run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/mariadb.sh /bin/
RUN chmod +x /bin/mariadb.sh


EXPOSE 3306


CMD ["/bin/mariadb.sh", "/usr/bin/mysqld_safe"]
