COMPOSE_FILE = srcs/compose.yaml

.PYHONY: up
up:
	docker-compose -f $(COMPOSE_FILE) up --build

.PYHONY: up-d
up-d:
	docker-compose -f $(COMPOSE_FILE) up -d --build

.PYHONY: stop
stop:
	docker-compose -f $(COMPOSE_FILE) stop

.PYHONY: restart
restart:
	docker-compose -f $(COMPOSE_FILE) restart

.PYHONY: down
down:
	docker-compose -f $(COMPOSE_FILE) down

.PYHONY: logs
logs:
	docker-compose -f $(COMPOSE_FILE) logs

.PYHONY: ps
ps:
	docker-compose -f $(COMPOSE_FILE) ps -a

.PYHONY: clean
clean:
	docker-compose -f $(COMPOSE_FILE) down --volumes --rmi all
	@if [ -n "$$(docker images -q)" ]; then docker rmi $$(docker images -q); fi
	@if [ -n "$$(docker ps -a -q)" ]; then docker rm $$(docker ps -a -q); fi
	@if [ -n "$$(docker images -f "dangling=true" -q)" ]; then docker rmi $$(docker images -f "dangling=true" -q); fi

.PYHONY: exec_mariadb
exec_mariadb:
	docker exec -it srcs_mariadb_1 sh

.PYHONY: exec_nginx
exec_nginx:
	docker exec -it srcs_nginx_1 sh

.PYHONY: exec_wordpress
exec_wordpress:
	docker exec -it srcs_wordpress_1 sh

.PYHONY: exec_adminer
exec_adminer:
	docker exec -it srcs_adminer_1 sh
