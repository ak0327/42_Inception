COMPOSE_FILE = srcs/compose.yaml

DIRS = srcs/requirements/mariadb \
       srcs/requirements/nginx \
       srcs/requirements/wordpress \
       srcs/requirements/bonus/adminer

DOCKER_FILES = $(addsuffix /Dockerfile, $(DIRS))

all: up-d

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
	docker-compose -f $(COMPOSE_FILE) ps

.PYHONY: ps-a
ps-a:
	docker-compose -f $(COMPOSE_FILE) ps -a

.PYHONY: clean
clean:
	docker-compose -f $(COMPOSE_FILE) down --volumes --rmi all
	@if [ -n "$$(docker images -q)" ]; then docker rmi -f $$(docker images -q); fi
	@if [ -n "$$(docker ps -a -q)" ]; then docker rm -f $$(docker ps -a -q); fi
	@if [ -n "$$(docker images -f "dangling=true" -q)" ]; then docker rmi -f $$(docker images -f "dangling=true" -q); fi

.PYHONY: re
re: clean up-d

.PYHONY: lint
lint:
	hadolint $(DOCKER_FILES)

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

