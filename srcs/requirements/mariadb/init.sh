#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/24 18:04:35 by mstrauss          #+#    #+#              #
#    Updated: 2025/02/24 18:04:35 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
set -e
set -x # DEBUG

DB_ROOT_USER=$(cat /run/secrets/db_root_user)
DB_ROOT_PASS=$(cat /run/secrets/db_root_pass)
DB_USER=$(cat /run/secrets/db_user)
DB_PASS=$(cat /run/secrets/db_pass)
DB_NAME=$(cat /run/secrets/db_name)

if [ -f "/var/lib/mysql/init_done.txt" ]; then
    echo "MariaDB already initialized, skipping setup."
    echo "Starting MariaDB server with command: $@"
    exec "$@"
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
MYSQL_PID=$!

until mysqladmin ping --silent; do
  echo "Waiting for MariaDB..."
  sleep 1
done

if ! mysql -e "USE ${DB_NAME}" 2>/dev/null || ! mysql -u root -p${DB_ROOT_PASS} -e "USE ${DB_NAME}" 2>/dev/null; then
    echo "Setting up database and users..."
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
    
    mysql -u root -p${DB_ROOT_PASS} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
    mysql -u root -p${DB_ROOT_PASS} -e "CREATE USER IF NOT EXISTS '${DB_ROOT_USER}'@'%' IDENTIFIED BY '${DB_ROOT_PASS}';"
    mysql -u root -p${DB_ROOT_PASS} -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_ROOT_USER}'@'%' WITH GRANT OPTION;"
    mysql -u root -p${DB_ROOT_PASS} -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
    mysql -u root -p${DB_ROOT_PASS} -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
    
    
    echo "Flushing privileges..."
    mysql -u root -p${DB_ROOT_PASS} -e "FLUSH PRIVILEGES;"
else
    echo "Database already exists, skipping setup."
fi

echo "Shutting down MariaDB..."
mysqladmin -u root -p${DB_ROOT_PASS} shutdown
echo "MariaDB initialization completed successfully."
set +x # DEBUG
touch /var/lib/mysql/init_done.txt
echo "Starting MariaDB server with command: $@"
exec "$@"
