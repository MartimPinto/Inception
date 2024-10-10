#!/bin/bash

# Ensure the data directory is initialized

service mariadb start


if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ] || [ -z "$DB_ROOT_PASS" ]; then
    echo "Error: One or more environment variables are not set."
    echo "DB_NAME: $DB_NAME"
    echo "DB_USER: $DB_USER"
    echo "DB_PASS: $DB_PASS"
    echo "DB_ROOT_PASS: $DB_ROOT_PASS"
    exit 1
fi

mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASS';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_ROOT_PASS');
EOF

sleep 5

service mariadb stop

exec "$@" 