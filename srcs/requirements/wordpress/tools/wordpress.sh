#!/bin/bash


# Fix permissions
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

# Create PHP-FPM run directory and PID file
mkdir -p /run/php/
touch /run/php/php7.4-fpm.pid

# Modify PHP-FPM to listen on port 9000 instead of a socket
sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/" "/etc/php/7.4/fpm/pool.d/www.conf"

# If WordPress is not already set up, download and install
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Wordpress: setting up..."

    mkdir -p /var/www/html
    cd /var/www/html

    # Remove any existing files
    rm -rf *

    # Download WP-CLI
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    if [ ! -f wp-cli.phar ]; then
        echo "Failed to download wp-cli.phar"
        exit 1
    fi

    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # Download and configure WordPress
    wp core download --allow-root
    wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb:3306
    wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

    echo "Wordpress: installation complete!"
fi

# Execute the CMD passed to the container (PHP-FPM)
/usr/sbin/php-fpm7.4 -F
