FROM debian:bullseye

ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG DB_ROOT_PASS

ENV DB_NAME=${DB_NAME}
ENV DB_USER=${DB_USER}
ENV DB_PASS=${DB_PASS}
ENV DB_ROOT_PASS=${DB_ROOT_PASS}

RUN apt update -y && apt upgrade -y
RUN apt-get install mariadb-server -y
RUN apt install vim -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb.sh /bin/mariadb.sh
RUN chmod +x /bin/mariadb.sh
RUN bash /bin/mariadb.sh


EXPOSE 3306

CMD ["/usr/bin/mysqld_safe"]
