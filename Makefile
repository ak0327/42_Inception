COMPOSE_YML = srcs/docker-compose.yml

up:
	docker-compose -f $(COMPOSE_YML) up -d --build

stop:
	docker-compose -f $(COMPOSE_YML) stop

restart:
	docker-compose -f $(COMPOSE_YML) restart

down:
	docker-compose -f $(COMPOSE_YML) down

log:
	docker-compose -f $(COMPOSE_YML) logs

ps:
	docker-compose -f $(COMPOSE_YML) ps -a

clean:
	docker-compose -f $(COMPOSE_YML) down --volumes --rmi all
	@if [ -n "$$(docker images -q)" ]; then docker rmi $$(docker images -q); fi
	@if [ -n "$$(docker ps -a -q)" ]; then docker rm $$(docker ps -a -q); fi
	@if [ -n "$$(docker images -f "dangling=true" -q)" ]; then docker rmi $$(docker images -f "dangling=true" -q); fi
