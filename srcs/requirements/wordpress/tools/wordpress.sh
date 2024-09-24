#!/bin/bash

DB_NAME="inception_db"
DB_USER="mcarneir"
DB_PASS="trains123"
DB_ROOT_PASS="42trains123"
WP_URL="mcarneir.42.fr"
WP_TITLE="webtitle"
WP_ADMIN_USR="mcarneirpriv"
WP_ADMIN_PASS="privtrains"
WP_ADMIN_EMAIL="mcarneir@student.42porto.com"


chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

mkdir -p /run/php/
touch /run/php/php7.4-fpm.pid

sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/" "/etc/php/7.4/fpm/pool.d/www.conf"

if [ ! -f /var/www/html/wordpress.php ]; then
		echo "Wordpress: setting up..."

		mkdir -p /var/www/html
		cd /var/www/html
		rm -rf *


R		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
		chmod +x wp-cli.phar 
		mv wp-cli.phar /usr/local/bin/wp
		wp core download --allow-root

		sleep 2

		wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb:3306
		wp core install --url=$WP_URL/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
fi

exec "$@"