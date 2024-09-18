FROM debian:buster

RUN apt-get upgrade && apt-get update -y && apt-get install -y php-fpm

CMD ["php-fpm8.2", "-F"]