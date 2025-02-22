# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/22 17:49:40 by mstrauss          #+#    #+#              #
#    Updated: 2025/02/22 21:50:56 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*      
    #removes package indexfiles -> leaner image

COPY conf /etc/nginx/nginx.conf

# COPY index.html /usr/share/nginx/html/ # Do we even do this, or is that part of wordpress?


RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/O=42Heilbronn/OU=Students/CN=42.fr"

# ENTRYPOINT [ "executable" ]

EXPOSE 443

HEALTHCHECK --interval=30s --timeout=5s \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
