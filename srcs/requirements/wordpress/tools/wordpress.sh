#!/bin/bash

chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

mkdir -p /run/php/
touch /run/php/php7.4-fpm.pid

sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/" "/etc/php/7.4/fpm/pool.d/www.conf"

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Wordpress: setting up..."

    mkdir -p /var/www/html
    cd /var/www/html
    rm -rf *

    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    if [ ! -f wp-cli.phar ]; then
        echo "Failed to download wp-cli.phar"
        exit 1
    fi

    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    echo "Downloading Wordpress core..."
    wp core download --allow-root

    while ! mysqladmin ping -hmariadb --silent; do
            echo "Waiting for MariaDb to be ready..."
            sleep 2
    done

    echo "Creating wp-config.php..."
    wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb:3306
    
    echo "Installing Wordpress..."
    wp core install --url="https://$WP_URL" --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --path="/var/www/html/" --allow-root
    
    echo "Creating subscribed user..."
    wp user create $DB_USER martimnp@gmail.com --role=subscriber --user_pass=$DB_PASS --allow-root

    echo "Wordpress: installation complete!"
fi

exec "$@"
