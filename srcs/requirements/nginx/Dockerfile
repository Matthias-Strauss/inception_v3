# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/22 17:49:40 by mstrauss          #+#    #+#              #
#    Updated: 2025/03/01 17:22:34 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    nginx \
    openssl \
    gettext-base \
    curl \
    && rm -rf /var/lib/apt/lists/*      
    #removes package indexfiles -> leaner image
    # gettext-base is needed envsubst() command
    
COPY default.conf.template /etc/nginx/conf.d/default.conf.template
RUN rm -f /etc/nginx/sites-enabled/default
# COPY index.html /usr/share/nginx/html/ # Do we even do this, or is that part of wordpress?

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/O=42Heilbronn/OU=Students/CN=42.fr"

# ENTRYPOINT [ "executable" ]

EXPOSE 443

HEALTHCHECK --interval=30s --timeout=5s CMD curl -f https://${DOMAIN_NAME}/ || exit 1

COPY init.sh /
RUN chmod +x /init.sh
ENTRYPOINT [ "/init.sh" ]

CMD ["nginx", "-g", "daemon off;"]
