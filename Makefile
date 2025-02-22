# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/22 17:16:04 by mstrauss          #+#    #+#              #
#    Updated: 2025/02/22 21:09:40 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception



up:
	docker compose up
	
re:
	docker compose up --build

down:
	docker compose down

.PHONY: up re down