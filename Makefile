SHELL = /bin/bash

PROJECT := web-hacking-toolkit

.PHONY : help compress extract build-image build run
.DEFAULT_GOAL = help

help:
	@echo ""
	@echo "*****************************************************************************"
	@echo ""
	@echo " PROJECT     : $(PROJECT)"
	@echo ""
	@echo "*****************************************************************************"
	@echo ""
	@echo " 1. make compress ......... compress configurations."
	@echo " 2. make extract .......... extract configurations."
	@echo " 3. make build-image ...... build the image."
	@echo " 4. make build ............ compress configurations then,"
	@echo "                            build the image."
	@echo " 5. make run .............. run a container and attach a shell"
	@echo ""

compress:
	@echo -e "\n + 7z compress scripts"; \
	[ -f ./scripts.7z ] && rm ./scripts.7z ; \
	7z a scripts.7z scripts; \
	echo -e "\n + 7z compress configurations"; \
	[ -f ./configurations.7z ] && rm ./configurations.7z ; \
	7z a configurations.7z configurations

extract:
	@echo -e "\n + 7z extract scripts"; \
	7z x scripts.7z; \
	echo -e "\n + 7z extract configurations"; \
	7z x configurations.7z

build-image:
	docker build . -f Dockerfile -t hueristiq/web-hacking-toolkit

build: compress build-image

run:
	@docker run \
		-it \
		--rm \
		--shm-size="2g" \
		--network host \
		-e DISPLAY=${DISPLAY} \
		-v "$(pwd)":/root/data \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--name web-hacking-toolkit \
		hueristiq/web-hacking-toolkit \
		/bin/zsh -l