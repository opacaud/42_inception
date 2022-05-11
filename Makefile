# NAME		= inception

# SRCS_DIR	= .
# INCLUDES	= .
# CXX			= clang++
# CXXFLAGS	= -Wall -Wextra -Werror -std=c++98 -g3
# DEP_FLAGS	= -MMD -MP

# OBJS_DIR	= objs

# SRCS		= main.cpp

# OBJS		= $(addprefix ${OBJS_DIR}/,${SRCS:.cpp=.o})

# DEP			= ${OBJS:.o=.d}

# all:		${NAME}

# ${NAME}:	${OBJS}
# 				${CXX} -I${INCLUDES} ${CXXFLAGS} ${DEP_FLAGS} ${OBJS} -o $@

# ${OBJS_DIR}/%.o:${SRCS_DIR}/%.cpp
# 				@mkdir -p ${@D}
# 				${CXX} ${CXXFLAGS} ${DEP_FLAGS} -c $< -o $@

# clean:
# 				rm -rf ${OBJS_DIR}

# fclean:			clean
# 				rm -f ${NAME}

# re:				fclean all

# .PHONY:			all clean fclean re

# -include ${DEP}







# sudo docker-compose up -d







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




YML	= srcs/docker-compose.yml

include srcs/.env
export $(shell sed 's/=.*//' srcs/.env)

all: up

up:
	@sudo mkdir -p /home/opacaud/data/mariadb
	@echo "/home/opacaud/data/mariadb folder created"
	@sudo mkdir -p /home/opacaud/data/wordpress_nginx
	@echo "/home/opacaud/data/wordpress_nginx folder created"
	docker-compose -f ${YML} up -d --build

down:
	docker-compose -f ${YML} down

help:
	@echo "usage: make [all] [up] [down] [fclean] [re]"
	@echo "make / make all / make up = docker-compose -f ${YML} up -d --build"
	@echo "make down = docker-compose -f ${YML} down"
	@echo "make fclean = docker-compose -f ${YML} down --rmi all"
	@echo "make re = fclean + all"

fclean:
	docker-compose -f ${YML} down --rmi all

re:	fclean all

.PHONY: all up down help fclean re
