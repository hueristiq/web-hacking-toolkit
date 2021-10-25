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
	@echo " 1. make build ................. build an image."
	@echo " 2. make run ................... run a container and attach a shell"
	@echo ""

build:
	@$(DOCKER) build . -f Dockerfile -t signedsecurity/web-hacking-toolkit

run:
	@$(DOCKER) run --rm -it --name web-hacking-toolkit signedsecurity/web-hacking-toolkit /usr/bin/zsh