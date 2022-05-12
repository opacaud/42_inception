# # THIS_FILE := $(lastword $(MAKEFILE_LIST))
# .PHONY: help build up start down destroy stop restart logs logs-api ps login-timescale login-api db-shell
# # help:
# #         make -pRrq  -f $(THIS_FILE) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
# build:
# 		docker-compose -f docker-compose.yml build $(c)
# up:
# 		docker-compose -f docker-compose.yml up -d $(c)
# start:
# 		docker-compose -f docker-compose.yml start $(c)
# down:
# 		docker-compose -f docker-compose.yml down $(c)
# destroy:
# 		docker-compose -f docker-compose.yml down -v $(c)
# stop:
# 		docker-compose -f docker-compose.yml stop $(c)
# restart:
# 		docker-compose -f docker-compose.yml stop $(c)
# 		docker-compose -f docker-compose.yml up -d $(c)
# logs:
# 		docker-compose -f docker-compose.yml logs --tail=100 -f $(c)
# logs-api:
# 		docker-compose -f docker-compose.yml logs --tail=100 -f api
# ps:
# 		docker-compose -f docker-compose.yml ps
# login-timescale:
# 		docker-compose -f docker-compose.yml exec timescale /bin/bash
# login-api:
# 		docker-compose -f docker-compose.yml exec api /bin/bash
# db-shell:
# 		docker-compose -f docker-compose.yml exec timescale psql -Upostgres

# make help— list all commands available for make
# make build — build the image from Dockerfile.
# In our example we have used an existing image of timescaledband ping.
# However, forapi , we want to build locally. This command will do that.
# make start — is used to start all the containers.
# To start only one container run make start c=timescale
# make login-timescale— is used to log-in to bash session in the timescale container.
# make db-shell — is used to log-in to the psql in the timescale container
# to run sql queries on the database
# make stop— is used to stop the container
# make down — is used to stop and remove containers.
# To delete specific container use make down c=timescaledb or make down c=api





SHELL=/bin/bash

# to see all colors, run
# bash -c 'for c in {0..255}; do tput setaf $c; tput setaf $c | cat -v; echo =$c; done'
# the first 15 entries are the 8-bit colors

# define standard colors
ifneq (,$(findstring xterm,${TERM}))
	BLACK        := $(shell tput -Txterm setaf 0)
	RED          := $(shell tput -Txterm setaf 1)
	GREEN        := $(shell tput -Txterm setaf 2)
	YELLOW       := $(shell tput -Txterm setaf 3)
	BLUE  		 := $(shell tput -Txterm setaf 4)
	PURPLE       := $(shell tput -Txterm setaf 5)
	LIGHTBLUE    := $(shell tput -Txterm setaf 6)
	WHITE        := $(shell tput -Txterm setaf 7)
	RESET 		 := $(shell tput -Txterm sgr0)
else
	BLACK        := ""
	RED          := ""
	GREEN        := ""
	YELLOW       := ""
	BLUE  		 := ""
	PURPLE       := ""
	LIGHTBLUE    := ""
	WHITE        := ""
	RESET        := ""
endif

YML	= srcs/docker-compose.yml

include srcs/.env
export $(shell sed 's/=.*//' srcs/.env)

all: up

ls:
	@echo -e "\n${GREEN}DOCKER LS${RESET}\n"
	@echo "${GREEN}---> IMAGES${RESET}"
	@docker image ls
	@echo -e "\n${GREEN}---> CONTAINERS${RESET}\n"
	@docker container ls

# https://docs.docker.com/compose/reference/up/
up:
	@sudo mkdir -p /home/opacaud/data/mariadb
	@echo -e "\n${GREEN}/home/opacaud/data/mariadb folder ready${RESET}"
	@sudo mkdir -p /home/opacaud/data/wordpress_nginx
	@echo -e "\n${GREEN}/home/opacaud/data/wordpress_nginx folder ready${RESET}"
	@echo -e "\n${GREEN}docker-compose up${RESET}\n"
	@docker-compose -f ${YML} up --detach --build --remove-orphans
	@echo -e "\n${GREEN}DOCKER LS${RESET}\n"
	@echo -e "\n${GREEN}---> IMAGES${RESET}\n"
	@docker image ls
	@echo -e "\n${GREEN}---> CONTAINERS${RESET}\n"
	@docker container ls

# https://docs.docker.com/compose/reference/down/
down: ls
	@echo -e "\n${GREEN}docker-compose down${RESET}\n"
	@docker-compose -f ${YML} down
	@echo -e "\n${GREEN}DOCKER LS${RESET}\n"
	@echo -e "\n${GREEN}---> IMAGES${RESET}\n"
	@docker image ls
	@echo -e "\n${GREEN}---> CONTAINERS${RESET}\n"
	@docker container ls

# https://docs.docker.com/compose/reference/down/
clean: ls
	@echo -e "\n${GREEN}docker-compose down --rmi all --remove-orphans${RESET}\n"
	@docker-compose -f ${YML} down --rmi all --remove-orphans
	@echo -e "\n${GREEN}DOCKER LS${RESET}\n"
	@echo -e "\n${GREEN}---> IMAGES${RESET}\n"
	@docker image ls
	@echo -e "\n${GREEN}---> CONTAINERS${RESET}\n"
	@docker container ls

# https://docs.docker.com/engine/reference/commandline/system_prune/
fclean: ls
	@echo -e "\n${GREEN}docker-compose -f ${YML} down --rmi all --volumes --remove-orphans${RESET}\n"
	@docker-compose -f ${YML} down --rmi all --volumes --remove-orphans
	@echo -e "\n${GREEN}docker system prune -f --all --volumes${RESET}\n"
	@docker system prune -f --all --volumes
	@sudo rm -rf /home/opacaud/data/mariadb /home/opacaud/data/wordpress_nginx
	@echo -e "\n${GREEN}DOCKER LS${RESET}\n"
	@echo -e "\n${GREEN}---> IMAGES${RESET}\n"
	@docker image ls
	@echo -e "\n${GREEN}---> CONTAINERS${RESET}\n"
	@docker container ls

re:	fclean all

help:
	@echo -e "\n${RED}usage: make [all] [up] [down] [fclean] [re]${RESET}\n"
	@echo "${GREEN}make / make all / make up${RESET} = docker-compose -f ${YML} up --detach --build --remove-orphans"
	@echo "${GREEN}make ls${RESET} = docker image ls + docker container ls"
	@echo "${GREEN}make down${RESET} = docker-compose -f ${YML} down"
	@echo "${GREEN}make clean${RESET} = docker-compose -f ${YML} down --rmi all --remove-orphans"
	@echo "${GREEN}make fclean${RESET} = clean + docker system prune -f --all --volumes"
	@echo -e "${GREEN}make re${RESET} = fclean + all\n"

.PHONY: all up ls down clean fclean re help
