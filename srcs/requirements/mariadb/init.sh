#!/bin/bash
set -e

DB_ROOT_USER=$(cat /run/secrets/db_root_user)
DB_ROOT_PASS=$(cat /run/secrets/db_root_pass)
DB_USER=$(cat /run/secrets/db_user)
DB_PASS=$(cat /run/secrets/db_pass)
DB_NAME=$(cat /run/secrets/db_name)


if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    mysqld --user=mysql --datadir=/var/lib/mysql &

  until mysqladmin ping --silent; do
    echo "Waiting for MariaDB..."
    sleep 1
  done

    mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

    # TODO: check if root@localhost needs to be defined differently
    # mysql -e "CREATE USER IF NOT EXISTS '${DB_ADMIN_USER}'@'%' IDENTIFIED BY '${DB_ADMIN_PASSWORD}';"
    mysql -e "RENAME USER 'root'@'localhost' TO '${DB_ROOT_USER}'@'localhost';"
    mysql -e "ALTER USER '${DB_ROOT_USER}'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_ROOT_USER}'@'%' WITH GRANT OPTION;"

    mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"

    # mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';" # redundant

    mysql -e "FLUSH PRIVILEGES;"
    mysqladmin shutdown
fi

exec "$@"
