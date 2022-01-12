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
	@echo " 1. make compress-configurations ..... compress configurations."
	@echo " 2. make extract-configurations ...... extract configurations."
	@echo " 3. make build-image ................. build the image."
	@echo " 4. make build ....................... compress configurations then,"
	@echo "                                       build the image."
	@echo " 5. make run ......................... run a container and attach a shell"
	@echo ""

compress-configurations:
	tar -czf configurations.tar.gz ./configurations

extract-configurations:
	tar -xzf configurations.tar.gz -C ./

build-image:
	docker build . -f Dockerfile -t signedsecurity/web-hacking-toolkit

build: compress-configurations build-image

run:
	@docker run \
		-it \
		--rm \
		--shm-size="2g" \
		--name web-hacking-toolkit2 \
		--hostname web-hacking-toolkit \
		-p 22:22 \
		-v $(pwd)/data:/root/data \
		signedsecurity/web-hacking-toolkit \
		/bin/bash