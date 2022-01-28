FROM signedsecurity/toolkits-base-debian:v1.2.0

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

COPY configurations.tar.gz /tmp/configurations.tar.gz

RUN \
	# up(date|grade)
	apt-get update && \
	apt-get upgrade -qq -y && \
	# extract configurations
	tar -xzf /tmp/configurations.tar.gz -C /tmp && \
	# install node, npm & yarn
	curl -fsSL https://deb.nodesource.com/setup_17.x | bash - && \
	apt-get install -qq -y nodejs && \
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