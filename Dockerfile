FROM signedsecurity/toolkits-base-debian:v1.1.0

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

COPY configurations.tar.gz /tmp/configurations.tar.gz

RUN \
	# up(date|grade)
	apt-get update && \
	apt-get upgrade -y --allow-downgrades && \
	# extract configurations
	tar -xzf /tmp/configurations.tar.gz -C /tmp && \
	# setup node & npm
	apt-get install -y --no-install-recommends \
		npm \
		nodejs && \
	# setup yarn
	npm install -g yarn 

COPY scripts $HOME/scripts

ENV HOME="/root"

RUN \
	for script in $(find $HOME/scripts/setup -maxdepth 1 -type f -print | sort); \
	do \
		echo ${script} && \
		chmod u+x ${script} && \
		${script}; \
	done && \
	rm -rf $HOME/scripts/setup && \
	chmod a+x $HOME/scripts/* && \
	# clean up
	for task in autoremove autoclean clean; \
	do \
		apt-get -y -qq ${task}; \
	done && \
	rm -rf /tmp/configurations* && \
	rm -rf /var/lib/apt/lists/* && \
	go clean -cache && \
	go clean -testcache && \
	go clean -modcache

WORKDIR $HOME