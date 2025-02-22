# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/22 17:16:04 by mstrauss          #+#    #+#              #
#    Updated: 2025/02/22 17:44:47 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception



up:
	docker compose up
	
re:

down:
	docker compose down

clean:

fclean:

.PHONY: 