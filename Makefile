SHELL=/bin/bash

BLACK        := $(shell tput -Txterm setaf 0)
RED          := $(shell tput -Txterm setaf 1)
GREEN        := $(shell tput -Txterm setaf 2)
YELLOW       := $(shell tput -Txterm setaf 3)
BLUE  		 := $(shell tput -Txterm setaf 4)
PURPLE       := $(shell tput -Txterm setaf 5)
LIGHTBLUE    := $(shell tput -Txterm setaf 6)
WHITE        := $(shell tput -Txterm setaf 7)
RESET 		 := $(shell tput -Txterm sgr0)


YML	= srcs/docker-compose.yml

include srcs/.env
export $(shell sed 's/=.*//' srcs/.env)

all: up

ls:
		@echo -e "\n${GREEN}--------------------------------------------------------------------------------${RESET}"
		@echo -e "${GREEN}---------------------------------------LS---------------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------------------------------------------------\n${RESET}"
		@echo -e "${GREEN}---> IMAGES${RESET}\n"
	@docker image ls
		@echo -e "\n${GREEN}---> CONTAINERS${RESET}\n"
	@docker container ls
		@echo -e "\n\n${GREEN}--------------------------------------------------------------------------------${RESET}"
		@echo -e "${GREEN}-------------------------------------END LS-------------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------------------------------------------------\n${RESET}"

# https://docs.docker.com/compose/reference/up/
up:
		@echo -e "\n\n${GREEN}--------------------------------------------------------------------------------${RESET}"
		@echo -e "${GREEN}---------------------------------------UP---------------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------------------------------------------------\n${RESET}"
	@sudo service nginx stop
	@sudo service mysql stop
		@echo -e "\n${GREEN}nginx and mysql automatic services stopped${RESET}" 
	@sudo mkdir -p /home/opacaud/data/mariadb
		@echo -e "\n${GREEN}/home/opacaud/data/mariadb folder on host machine ready${RESET}"
	@sudo mkdir -p /home/opacaud/data/wordpress
		@echo -e "\n${GREEN}/home/opacaud/data/wordpress folder on host machine ready${RESET}"
		@echo -e "\n${GREEN}docker-compose up --detach --build${RESET}\n"
	@docker-compose -f ${YML} up --detach --build
	@docker system prune -f > /dev/null 2>&1
		@echo -e "\n${GREEN}DOCKER LS${RESET}\n"
		@echo -e "\n${GREEN}---> IMAGES${RESET}\n"
	@docker image ls
		@echo -e "\n${GREEN}---> CONTAINERS${RESET}\n"
	@docker container ls
		@echo -e "\n\n${GREEN}--------------------------------------------------------------------------------${RESET}"
		@echo -e "${GREEN}-------------------------------------END UP-------------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------------------------------------------------\n${RESET}"

# https://docs.docker.com/compose/reference/down/
down: ls
		@echo -e "\n\n${GREEN}--------------------------------------------------------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------DOWN--------------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------------------------------------------------\n${RESET}"
		@echo -e "\n${GREEN}docker-compose down${RESET}\n"
	@docker-compose -f ${YML} down
		@echo -e "\n${GREEN}DOCKER LS${RESET}\n"
		@echo -e "\n${GREEN}---> IMAGES${RESET}\n"
	@docker image ls
		@echo -e "\n${GREEN}---> CONTAINERS${RESET}\n"
	@docker container ls
		@echo -e "\n\n${GREEN}--------------------------------------------------------------------------------${RESET}"
		@echo -e "${GREEN}------------------------------------END DOWN------------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------------------------------------------------\n${RESET}"

# https://docs.docker.com/compose/reference/down/
clean: ls
		@echo -e "\n\n${GREEN}--------------------------------------------------------------------------------${RESET}"
		@echo -e "${GREEN}-------------------------------------CLEAN--------------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------------------------------------------------\n${RESET}"
		@echo -e "\n${GREEN}docker-compose down --rmi all --remove-orphans${RESET}\n"
	@docker-compose -f ${YML} down --rmi all --remove-orphans
		@echo -e "\n${GREEN}DOCKER LS${RESET}\n"
		@echo -e "\n${GREEN}---> IMAGES${RESET}\n"
	@docker image ls
		@echo -e "\n${GREEN}---> CONTAINERS${RESET}\n"
	@docker container ls
		@echo -e "\n\n${GREEN}--------------------------------------------------------------------------------${RESET}"
		@echo -e "${GREEN}-----------------------------------END CLEAN------------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------------------------------------------------\n${RESET}"

# https://docs.docker.com/engine/reference/commandline/system_prune/
fclean: ls
		@echo -e "\n\n${GREEN}--------------------------------------------------------------------------------${RESET}"
		@echo -e "${GREEN}-------------------------------------FCLEAN-------------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------------------------------------------------\n${RESET}"
		@echo -e "\n${GREEN}docker-compose -f ${YML} down --rmi all --volumes --remove-orphans${RESET}\n"	
	@docker-compose -f ${YML} down --rmi all --volumes --remove-orphans
		@echo -e "\n${GREEN}docker system prune -f --all --volumes${RESET}\n"
	@docker system prune -f --all --volumes
		@echo -e "\n\n${GREEN}rm -rf /home/opacaud/data/mariadb /home/opacaud/data/wordpress${RESET}\n"
	@sudo rm -rf /home/opacaud/data/mariadb /home/opacaud/data/wordpress
		@echo -e "\n${GREEN}---> IMAGES${RESET}\n"
	@docker image ls
		@echo -e "\n${GREEN}---> CONTAINERS${RESET}\n"
	@docker container ls
		@echo -e "\n\n${GREEN}--------------------------------------------------------------------------------${RESET}"
		@echo -e "${GREEN}-----------------------------------END FCLEAN-----------------------------------${RESET}"
		@echo -e "${GREEN}--------------------------------------------------------------------------------\n${RESET}"

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
