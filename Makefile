DC_FILE = srcs/docker-compose.yml

up:
	docker-compose -f $(DC_FILE) up -d

re:
	docker-compose -f $(DC_FILE) up -d --build

down:
	docker-compose -f $(DC_FILE) down --rm all

logs:
	docker-compose -f $(DC_FILE) logs

ps:
	docker-compose -f $(DC_FILE) ps -a

#rmi:
#	docker rmi $(docker images -q)
#
#rm:
#	docker rm $(docker ps -a -q)
#	docker rmi $(docker images -f "dangling=true" -q)

#clean: rmi rm
