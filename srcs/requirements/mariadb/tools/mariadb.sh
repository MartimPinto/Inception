#!/bin/bash

# Ensure the data directory is initialized

service mariadb start


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
