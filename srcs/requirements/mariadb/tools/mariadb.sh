#!/bin/bash

mysql_install_db --user=mysql --ldata=/var/lib/mysql

mysqld_safe &
sleep 5


cat >/tmp/db.sql << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
FLUSH PRIVILEGES;
EOF

mysql -uroot </tmp/db.sql
if [ $? -eq 0 ]; then
	echo "SQL script executed successfully."
else
	echo "Error executing SQL script."
	exit 1
fi

service mariadb stop

exec "$@"