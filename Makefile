# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstrauss <mstrauss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/22 17:16:04 by mstrauss          #+#    #+#              #
#    Updated: 2025/03/01 14:13:09 by mstrauss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

up:
	docker compose build && docker compose up
	
re: clean
	docker compose down -v && docker compose build --no-cache && docker compose up

fre: fclean
	docker compose down -v && docker compose build --no-cache && docker compose up

down:
	docker compose down

clean:
	docker compose down -v
	docker volume prune -f

fclean: clean
	docker system prune -af --volumes

.PHONY: up re down clean fclean