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

CONFIG_FILE="/var/www/html/wp-config.php"
# SAMPLE_FILE="/var/www/html/wp-config-sample.php"



exec "$@"