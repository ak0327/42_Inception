COMPOSE_FILE = srcs/compose.yaml

DIRS = srcs/requirements/mariadb \
       srcs/requirements/nginx \
       srcs/requirements/wordpress \
       srcs/requirements/bonus/adminer

DOCKER_FILES = $(addsuffix /Dockerfile, $(DIRS))

###########################################################################

all: start

###########################################################################

.PYHONY: up
up:
	docker-compose -f $(COMPOSE_FILE) up --build

.PYHONY: start
start:
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

.PYHONY: network_rm
network_rm:
	docker network ls -q | xargs -r docker network rm

.PYHONY: clean
clean:
	make down
	docker-compose -f $(COMPOSE_FILE) down --volumes --rmi all
	@if [ -n "$$(docker images -q)" ]; then docker rmi -f $$(docker images -q); fi
	@if [ -n "$$(docker ps -a -q)" ]; then docker rm -f $$(docker ps -a -q); fi
	@if [ -n "$$(docker images -f "dangling=true" -q)" ]; then docker rmi -f $$(docker images -f "dangling=true" -q); fi
	make network_rm

.PYHONY: re
re: clean up-d

###########################################################################

.PYHONY: logs
logs:
	docker-compose -f $(COMPOSE_FILE) logs

.PYHONY: log_nginx
log_nginx:
	docker-compose -f $(COMPOSE_FILE) logs nginx

.PYHONY: log_mariadb
log_mariadb:
	docker-compose -f $(COMPOSE_FILE) logs mariadb


.PYHONY: ps
ps:
	docker-compose -f $(COMPOSE_FILE) ps

.PYHONY: ps-a
ps-a:
	docker-compose -f $(COMPOSE_FILE) ps -a

###########################################################################

.PYHONY: lint
lint:
	hadolint $(DOCKER_FILES)

###########################################################################

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

.PYHONY: exec_dnsmasq
exec_dnsmasq:
	docker exec -it srcs_dnsmasq_1 sh

.PYHONY: exec_redis
exec_redis:
	docker exec -it srcs_redis_1 sh

.PYHONY: exec_hugo
exec_hugo:
	docker exec -it srcs_hugo_1 sh

