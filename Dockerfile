FROM kalilinux/kali-rolling:latest

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

RUN \
	# up(date|grade)
	apt-get update && \
	apt-get upgrade -qq -y && \
	# install essentials
	apt-get install -y --no-install-recommends \
		tar \
		git \
		curl \
		wget \
		tree \
		unzip \
		xauth \
		libxss1 \
		locales \
		apt-utils \
		build-essential && \
	# install/generate locales
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
	# setup python3
	apt-get install -y --no-install-recommends \
		python3 \
		python3-dev \
		python3-pip \
		python3-venv && \
	# setup go(golang)
	curl -sL https://golang.org/dl/go1.17.6.linux-amd64.tar.gz -o /tmp/go1.17.6.linux-amd64.tar.gz && \
	tar -xzf /tmp/go1.17.6.linux-amd64.tar.gz -C /usr/local && \
	rm -rf /tmp/go1.17.6.linux-amd64.tar.gz && \
	# install node, npm & yarn
	curl -fsSL https://deb.nodesource.com/setup_17.x | bash - && \
	apt-get install -qq -y nodejs && \
	npm install -g yarn

ENV HOME="${HOME}" \
	LANG="en_US.utf8" \
	GOPATH="${HOME}/go" \
	GOROOT="/usr/local/go" \
	PATH="$PATH:/usr/local/go/bin:${HOME}/go/bin:${HOME}/scripts"

COPY scripts $HOME/scripts
COPY configurations.tar.gz /tmp/configurations.tar.gz

RUN \
	# make scripts executable
	chmod a+x $HOME/scripts/* && \
	# extract configurations
	tar -xzf /tmp/configurations.tar.gz -C /tmp && \
	# run setup scripts
	for script in $(find $HOME/scripts/setup -maxdepth 1 -type f -print | sort); \
	do \
		echo ${script} && \
		chmod u+x ${script} && \
		${script}; \
	done && \
	# clean up
	# remove setup scripts
	rm -rf $HOME/scripts/setup && \
	# remove configuration remnants
	rm -rf /tmp/configurations* && \
	# auto(remove|clean) & clean
	for task in autoremove autoclean clean; \
	do \
		apt-get -y -qq ${task}; \
	done && \
	rm -rf /var/lib/apt/lists/* && \
	go clean -cache && \
	go clean -testcache && \
	go clean -modcache

WORKDIR $HOME