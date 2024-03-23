COMPOSE_FILE = srcs/docker-compose.yml

DOCKER_DIRS = srcs/requirements/mariadb \
       srcs/requirements/nginx \
       srcs/requirements/wordpress \
       srcs/requirements/bonus/adminer

DOCKER_FILES = $(addsuffix /Dockerfile, $(DOCKER_DIRS))

ENV_SH = srcs/make_env.sh
ENV_PATH = srcs/.env


########################################################################################################################


all: start


########################################################################################################################


.PYHONY: up
up: env init_volume
	docker-compose -f $(COMPOSE_FILE) up --build


.PYHONY: start
start: env init_volume
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


.PYHONY: clean
clean: down
	@if [ -n "$$(docker ps -a -q)" ]; then docker stop $$(docker ps -a -q); fi
	@if [ -n "$$(docker ps -a -q)" ]; then docker rm -f $$(docker ps -a -q); fi
	@#if [ -n "$$(docker images -q)" ]; then docker rmi -f $$(docker images -q); fi
	@if [ -n "$$(docker images -f "dangling=true" -q)" ]; then docker rmi -f $$(docker images -f "dangling=true" -q); fi
	@docker network rm $$(docker network ls -q) 2>/dev/null || true
	@docker volume prune -f


.PYHONY: fclean
fclean: clean clear_volume


.PYHONY: init_volume
init_volume:
	$(eval DB_VOLUME_DIR := $(if $(DB_VOLUME_DIR), $(DB_VOLUME_DIR), /home/takira/data/mariadb))
	$(eval WP_VOLUME_DIR := $(if $(WP_VOLUME_DIR), $(WP_VOLUME_DIR), /home/takira/data/wordpress))
	$(eval HUGO_VOLUME_DIR := $(if $(HUGO_VOLUME_DIR), $(HUGO_VOLUME_DIR), /home/takira/data/hugo))
	sudo mkdir -p ${DB_VOLUME_DIR} ${WP_VOLUME_DIR} ${HUGO_VOLUME_DIR}


.PYHONY: clear_volume
clear_volume:
	$(eval DB_VOLUME_DIR := $(if $(DB_VOLUME_DIR), $(DB_VOLUME_DIR), /home/takira/data/mariadb))
	$(eval WP_VOLUME_DIR := $(if $(WP_VOLUME_DIR), $(WP_VOLUME_DIR), /home/takira/data/wordpress))
	$(eval HUGO_VOLUME_DIR := $(if $(HUGO_VOLUME_DIR), $(HUGO_VOLUME_DIR), /home/takira/data/hugo))
	sudo rm -rf ${DB_VOLUME_DIR} ${WP_VOLUME_DIR} ${HUGO_VOLUME_DIR}


.PYHONY: re
re: fclean start


.PYHONY: env
env:
	@./$(ENV_SH) $(ENV_PATH)


########################################################################################################################


.PYHONY: logs
logs:
	docker-compose -f $(COMPOSE_FILE) logs

.PYHONY: log_nginx
log_nginx:
	docker-compose -f $(COMPOSE_FILE) logs nginx

.PYHONY: log_wp
log_wp:
	docker-compose -f $(COMPOSE_FILE) logs wordpress

.PYHONY: log_mariadb
log_mariadb:
	docker-compose -f $(COMPOSE_FILE) logs mariadb

.PYHONY: log_ftpd
log_ftpd:
	docker-compose -f $(COMPOSE_FILE) logs ftpd

.PYHONY: ps
ps:
	docker-compose -f $(COMPOSE_FILE) ps

.PYHONY: ps-a
ps-a:
	docker-compose -f $(COMPOSE_FILE) ps -a


########################################################################################################################


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

.PYHONY: exec_ftpd
exec_ftpd:
	docker exec -it srcs_ftpd_1 sh


########################################################################################################################


.PYHONY: lint
lint:
	@hadolint --version
	@hadolint $(DOCKER_FILES) \
	&& echo "\033[0;32mHADOLINT DONE\033[0m" \
	|| echo "\033[0;31mHADOLINT ERROR\033[0m"
