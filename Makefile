SHELL = /bin/bash

.DEFAULT_GOAL = help

PROJECT := web-hacking-toolkit
DOCKER ?= docker

help:
	@echo ""
	@echo "*****************************************************************************"
	@echo ""
	@echo " PROJECT     : $(PROJECT)"
	@echo ""
	@echo "*****************************************************************************"
	@echo ""
	@echo " 1. make build ................. create and start containers."
	@echo " 2. make push .................. build or rebuild services"
	@echo ""

build:
	@$(DOCKER) build . -f Dockerfile -t signedsecurity/web-hacking-toolkit

push:
	@$(DOCKER) push signedsecurity/web-hacking-toolkit:latest