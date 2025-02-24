# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/23 17:19:04 by mstrauss          #+#    #+#              #
#    Updated: 2025/02/24 14:42:44 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# WORKDIR

#check if neccessary
VOLUME /var/lib/mysql

#not neccessary according to documentation. check later A/B with/without
EXPOSE 3306

RUN

COPY init.sh .

RUN chmod +x init.sh

ENTRYPOINT [ "init.sh" ]
CMD ["mysqld"]