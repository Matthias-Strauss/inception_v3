# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/23 17:19:04 by mstrauss          #+#    #+#              #
#    Updated: 2025/03/01 16:58:31 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
    sed -i 's/^#port/port/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
    sed -i 's/^port\s*=\s*.*/port = 3306/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Directories and Permissions
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql

#check if neccessary
VOLUME /var/lib/mysql

#not neccessary according to documentation. check later A/B with/without
EXPOSE 3306

COPY init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh

ENTRYPOINT ["/usr/local/bin/init.sh"]
CMD ["mysqld"]
