SHELL = /bin/bash

PROJECT := web-hacking-toolkit

.PHONY : help compress-configurations extract-configurations build-image build run
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
	@echo " 2. make de-compress ...... extract configurations."
	@echo " 3. make build-image ...... build the image."
	@echo " 4. make build ............ compress configurations then,"
	@echo "                            build the image."
	@echo " 5. make run .............. run a container and attach a shell"
	@echo ""

compress:
	@echo -e "\n + 7z compress scripts"; \
	7z a scripts.7z scripts; \
	echo -e "\n + 7z compress dotfiles"; \
	7z a dotfiles.7z dotfiles

de-compress:
	@echo -e "\n + 7z de-compress scripts"; \
	7z x scripts.7z; \
	echo -e "\n + 7z de-compress dotfiles"; \
	7z x dotfiles.7z

build-image:
	docker build . -f Dockerfile -t signedsecurity/web-hacking-toolkit

build: compress build-image

run:
	@docker run \
		-it \
		--rm \
		--shm-size="2g" \
		--name web-hacking-toolkit \
		--hostname web-hacking-toolkit \
		-p 22:22 \
		-v $(pwd)/data:/root/data \
		signedsecurity/web-hacking-toolkit \
		/bin/zsh -l