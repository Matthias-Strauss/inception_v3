# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/23 11:29:09 by mstrauss          #+#    #+#              #
#    Updated: 2025/02/23 17:34:30 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    php8.3-fpm \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /var/www/html
#is this neccessary?

RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && rm latest.tar.gz \
    && mv wordpress/* . \
    && rmdir wordpress

COPY <source> <destination>

CMD ["<command>"]
