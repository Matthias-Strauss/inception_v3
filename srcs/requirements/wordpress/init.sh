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
# set -x # DEBUG

DB_NAME=$(cat /run/secrets/db_name)
DB_USER=$(cat /run/secrets/db_user)
DB_PASS=$(cat /run/secrets/db_pass)
DB_HOST=${WORDPRESS_DB_HOST:-mariadb}
SITE_URL=${DOMAIN_NAME:-"localhost"}
DB_ROOT_USER=$(cat /run/secrets/db_root_user)
DB_ROOT_PASS=$(cat /run/secrets/db_root_pass)

echo "Checking if WordPress is already initialized..."
if [ -f /var/www/html/init_done.txt ]; then
  echo "Initialization already done. Starting PHP-FPM..."
  exec "$@"
fi

echo "Waiting for MariaDB..."

until nc -z "$DB_HOST" 3306; do
  echo "Still waiting for database at $DB_HOST..."
  sleep 3
done
echo "MariaDB port is open!"
echo "Waiting additional time for MariaDB to be ready..."
sleep 5

echo "Testing database connection..."
if ! mysql -h "$DB_HOST" -u "$DB_ROOT_USER" -p"$DB_ROOT_PASS" -e "USE $DB_NAME"; then
    echo "Failed to connect to database. Check credentials and try again."
    echo "DB_NAME: $DB_NAME"
    echo "DB_ROOT_USER: $DB_ROOT_USER"
    echo "DB_HOST: $DB_HOST"
    echo "Retrying in 5 seconds..."
    sleep 5
    if ! mysql -h "$DB_HOST" -u "$DB_ROOT_USER" -p"$DB_ROOT_PASS" -e "USE $DB_NAME"; then
        echo "Still unable to connect to database. Exiting."
        exit 1
    fi
fi
echo "Successfully connected to database!"

if [ -f /var/www/html/wp-config.php ]; then
    echo "Removing existing wp-config.php..."
    rm /var/www/html/wp-config.php
fi

echo "Creating wp-config.php via wp-cli..."
wp config create \
  --dbname="$DB_NAME" \
  --dbuser="$DB_ROOT_USER" \
  --dbpass="$DB_ROOT_PASS" \
  --dbhost="$DB_HOST" \
  --path="/var/www/html" \
  --skip-check \
  --allow-root
echo "wp-config.php created successfully."

echo "Checking if WordPress is installed..."
if ! wp core is-installed --path="/var/www/html" --allow-root; then
    echo "Installing WordPress core..."
    wp core install \
      --url="$SITE_URL" \
      --title="Inception" \
      --admin_user="$DB_ROOT_USER" \
      --admin_password="$DB_ROOT_PASS" \
      --admin_email="mstrauss@student.42heilbronn.de" \
      --path="/var/www/html" \
      --allow-root
    
    echo "WordPress core installed successfully."
    
    echo "Creating a regular user..."
    wp user create \
      $DB_USER \
      $DB_USER@student.42heilbronn.de \
      --role=subscriber \
      --user_pass=$DB_PASS \
      --path="/var/www/html" \
      --allow-root
    
    echo "Second user created successfully."
else
    echo "WordPress is already installed."
fi

echo "WordPress initialization complete. Starting PHP-FPM..."
touch init_done.txt
# set +x # DEBUG
exec "$@"
