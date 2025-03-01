# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/23 11:29:09 by mstrauss          #+#    #+#              #
#    Updated: 2025/03/01 17:14:40 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    curl \
    php-mbstring \
    less \
    netcat \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress/* . && \
    rmdir wordpress

# PHP-FPM config
RUN echo '[www]' > /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'user = www-data' >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'group = www-data' >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'listen = 9000' >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'listen.owner = www-data' >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'listen.group = www-data' >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'listen.mode = 0660' >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'pm = dynamic' >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'pm.max_children = 5' >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'pm.start_servers = 2' >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'pm.min_spare_servers = 1' >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo 'pm.max_spare_servers = 3' >> /etc/php/7.4/fpm/php-fpm.conf

COPY init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh

ENTRYPOINT ["/usr/local/bin/init.sh"]
CMD ["php-fpm7.4", "-F"]
