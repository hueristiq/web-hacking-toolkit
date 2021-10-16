SHELL = /bin/bash

.DEFAULT_GOAL = help

PROJECT := web-hacking-toolkit
DOCKER_COMPOSE ?= docker-compose

help:
	@echo ""
	@echo "*****************************************************************************"
	@echo ""
	@echo " PROJECT     : $(PROJECT)"
	@echo ""
	@echo "*****************************************************************************"
	@echo ""
	@echo " 1. make compose-up ................. create and start containers."
	@echo " 2. make compose-build .............. build or rebuild services"
	@echo " 2. make compose-start .............. start services."
	@echo " 3. make compose-ps ................. list containers."
	@echo " 3. make compose-images ............. list images."
	@echo " 4. make compose-stop ............... stop services."
	@echo " 5. make compose-down ............... stop and remove containers, networks,"
	@echo "                                      images, and volumes."
	@echo " 6. make compose-attach-shell ....... attach a shell."
	@echo ""

compose-build:
	@$(DOCKER_COMPOSE) \
		--file deployments/docker-compose/docker-compose.yml \
				--project-directory . \
					--project-name $(PROJECT) \
					build

compose-up:
	@$(DOCKER_COMPOSE) \
		--file deployments/docker-compose/docker-compose.yml \
				--project-directory . \
					--project-name $(PROJECT) \
					up -d

compose-images:
	@$(DOCKER_COMPOSE) \
		--file deployments/docker-compose/docker-compose.yml \
				--project-directory . \
					--project-name $(PROJECT) \
						images

compose-ps:
	@$(DOCKER_COMPOSE) \
		--file deployments/docker-compose/docker-compose.yml \
				--project-directory . \
					--project-name $(PROJECT) \
						ps

compose-start:
	@$(DOCKER_COMPOSE) \
		--file deployments/docker-compose/docker-compose.yml \
				--project-directory . \
					--project-name $(PROJECT) \
						start

compose-restart:
	@$(DOCKER_COMPOSE) \
		--file deployments/docker-compose/docker-compose.yml \
				--project-directory . \
					--project-name $(PROJECT) \
						restart

compose-stop:
	@$(DOCKER_COMPOSE) \
		--file deployments/docker-compose/docker-compose.yml \
				--project-directory . \
					--project-name $(PROJECT) \
						stop

compose-down:
	@$(DOCKER_COMPOSE) \
		--file deployments/docker-compose/docker-compose.yml \
				--project-directory . \
					--project-name $(PROJECT) \
						down

compose-attach-shell:
	@$(DOCKER_COMPOSE) \
		--file deployments/docker-compose/docker-compose.yml \
				--project-directory . \
					--project-name $(PROJECT) \
						exec web-hacking-toolkit /usr/bin/zsh --login