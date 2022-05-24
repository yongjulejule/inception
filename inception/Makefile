
COMPOSE := docker-compose
COMPOSE_FILE := ./srcs/docker-compose.yml

DB_CONT := mariadb
NGINX_CONT := nginx
WD_CONT := wordpress

IMGS := $(shell  docker images | grep inception | sed  -e "s/\ \+/ /g" | cut -d' ' -f3)

########################## Rule ##########################

.PHONY 		: help
help			:
					@printf "Usage: make [rule] [c=option]\n\n\n"
					@printf "%-17s  %s\n\n" "Rules" "Description"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "help"
					@printf $(L_GREEN)"%s \n"$(RESET)  "show this message"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "build"
					@printf $(L_GREEN)"%s \n"$(RESET)  "build image"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "rebuild"
					@printf $(L_GREEN)"%s \n"$(RESET)  "build image with --no-cache"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "start"
					@printf $(L_GREEN)"%s \n"$(RESET)  "run containers in background"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "restart"
					@printf $(L_GREEN)"%s \n"$(RESET)  "rerun containers"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "up"
					@printf $(L_GREEN)"%s \n"$(RESET)  "run containers in foreground"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "down"
					@printf $(L_GREEN)"%s \n"$(RESET)  "down containers. [optional] if [c="-v"] is given, erese volumes"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "top"
					@printf $(L_GREEN)"%s \n"$(RESET)  "show containers process status"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "ps"
					@printf $(L_GREEN)"%s \n"$(RESET)  "show containers processes"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "logs"
					@printf $(L_GREEN)"%s \n"$(RESET)  "show log of the containers"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "exec"
					@printf $(L_GREEN)"%s \n"$(RESET)  "with [c='cmd'], execute the cmd for each containers"

					@printf $(L_PUPLE)"%-17s  "$(RESET) "clean"
					@printf $(L_GREEN)"%s \n"$(RESET)  "remove images named inception_*"

.PHONY		: build
build			:
					$(COMPOSE) -f $(COMPOSE_FILE) build

.PHONY		: rebuild
rebuild		:
					$(COMPOSE) -f $(COMPOSE_FILE) build --no-cache

.PHONY 		: start
start			:
					$(COMPOSE) -f $(COMPOSE_FILE) up -d

.PHONY		: re
re				:
					make rebuild
					make start

.PHONY 		: restart
restart		:
					$(COMPOSE) -f $(COMPOSE_FILE) restart

.PHONY 		: up
up				:
					$(COMPOSE) -f $(COMPOSE_FILE) up

.PHONY 		: down
down			:
					$(COMPOSE) -f $(COMPOSE_FILE) down $(c)

.PHONY 		: top
top				:
					$(COMPOSE) -f $(COMPOSE_FILE) top

.PHONY 		: ps
ps				:
					$(COMPOSE) -f $(COMPOSE_FILE) ps

.PHONY		: log
log				:
					$(COMPOSE) -f $(COMPOSE_FILE) logs

.PHONY		: exec
exec			: 
ifeq ($(c), noarg)
						@echo $(RED)cmd is not given! Usage: c='cmd'$(RESET)
else
						@echo $(c)
						$(COMPOSE) -f $(COMPOSE_FILE) exec $(DB_CONT) $(c)
						$(COMPOSE) -f $(COMPOSE_FILE) exec $(NGINX_CONT) $(c)
						$(COMPOSE) -f $(COMPOSE_FILE) exec $(WD_CONT) $(c)
endif

.PHONY		: clean
clean			: 
					make down c="-v"
					docker image rm $(IMGS)

######################### Color #########################
GREEN="\033[32m"
L_GREEN="\033[1;32m"
RED="\033[31m"
L_RED="\033[1;31m"
RESET="\033[0m"
BOLD="\033[1m"
L_PUPLE="\033[1;35m"
L_CYAN="\033[1;96m"
UP = "\033[A"
CUT = "\033[K"
