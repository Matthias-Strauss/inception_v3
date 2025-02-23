# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/22 17:16:04 by mstrauss          #+#    #+#              #
#    Updated: 2025/02/23 11:48:55 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

up:
	docker compose build && docker compose up
	
re:
	docker compose build --no-cache && docker compose up

down:
	docker compose down

.PHONY: up re down