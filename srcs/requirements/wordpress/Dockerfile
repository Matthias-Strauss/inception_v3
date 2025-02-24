# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/23 11:29:09 by mstrauss          #+#    #+#              #
#    Updated: 2025/02/24 18:22:07 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    php8.3-fpm \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /var/www/html

RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && rm latest.tar.gz \
    && mv wordpress/* . \
    && rmdir wordpress

COPY init.sh .
RUN chmod +x init.sh

ENTRYPOINT [ "init.sh" ]
CMD ["php-fpm8.3", "-F"]
