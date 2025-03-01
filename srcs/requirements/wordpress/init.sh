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

DB_NAME=$(cat /run/secrets/db_name)
DB_USER=$(cat /run/secrets/db_user)
DB_PASS=$(cat /run/secrets/db_pass)
DB_HOST=${WORDPRESS_DB_HOST:-mariadb}
SITE_URL=${DOMAIN_NAME:-"localhost"}
WP_ROOT_USER=$(cat /run/secrets/wp_root_user)
WP_ROOT_PASS=$(cat /run/secrets/wp_root_pass)


echo "Waiting for MariaDB..."

while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent 2>/dev/null; do
  echo "Still waiting for database at $WORDPRESS_DB_HOST..."
  sleep 3
done
echo "MariaDB is ready!"

echo "Checking for wp-config.php..."
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php via wp-cli..."
    wp config create \
      --dbname="$DB_NAME" \
      --dbuser="$DB_USER" \
      --dbpass="$DB_PASS" \
      --dbhost="$DB_HOST" \
      --path="/var/www/html" \
      --skip-check \
      --allow-root
fi
    echo "wp-config.php created successfully."
else
    echo "wp-config.php already exists."
fi

echo "Checking if WordPress is installed..."
if ! wp core is-installed --path="/var/www/html" --allow-root; then
    echo "Installing WordPress core..."
    wp core install \
      --url="$SITE_URL" \
      --title="Inception" \
      --admin_user="$WP_ROOT_USER" \
      --admin_password="$WP_ROOT_PASS" \
      --admin_email="mstrauss@student.42heilbronn.de" \
      --path="/var/www/html" \
      --allow-root
    
    echo "WordPress core installed successfully."
else
    echo "WordPress is already installed."
fi

echo "WordPress initialization complete. Starting PHP-FPM..."
exec "$@"
