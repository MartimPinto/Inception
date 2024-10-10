#!/bin/bash
mysql_install_db --user=mysql --ldata=/var/lib/mysql
# Start MariaDB in the background
mysqld_safe &
sleep 5  # Give MariaDB some time to fully start

# Prepare the SQL script to create the database and user
cat >/tmp/db.sql << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASS';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
FLUSH PRIVILEGES;
EOF

# Check if MariaDB is ready before running the SQL script
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Execute the SQL script
mysql -uroot -p"$DB_ROOT_PASS" < /tmp/db.sql
if [ $? -eq 0 ]; then
    echo "SQL script executed successfully."
else
    echo "Error executing SQL script."
    exit 1
fi


# Run the command passed as arguments to the script
exec "$@"