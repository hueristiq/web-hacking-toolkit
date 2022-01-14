FROM debian:latest

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

COPY configurations.tar.gz /tmp/configurations.tar.gz

RUN \
	# up(date|grade)
	apt-get update && \
	apt-get upgrade -y && \
	# install essentials
	apt-get install -y --no-install-recommends \
		tar \
		curl \
		gnupg \
		locales \
		ca-certificates && \
	rm -rf /var/lib/apt/lists/* && \
	# install/generate locales
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
	# extract configurations
	tar -xzf /tmp/configurations.tar.gz -C /tmp && \
	# add kali linux repository
	echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list && \
	curl -sL 'https://archive.kali.org/archive-key.asc' -o archive-key.asc && \
	apt-key add archive-key.asc && \
	rm -rf archive-key.asc && \
	mv /tmp/configurations/apt/wht.pref /etc/apt/preferences.d/wht.pref && \
	# up(date|grade)
	apt-get update && \
	apt-get upgrade -y --allow-downgrades && \
	# install essentials
	apt-get install -y --no-install-recommends \
		jq \
		git \
		vim \
		tmux \
		wget \
		nmap \
		tree \
		arjun \
		unzip \
		xauth \
		whois \
		locales \
		python3 \
		libxss1 \
		masscan \
		whatweb \
		burpsuite \
		net-tools \
		libpcap-dev \
		python3-pip \
		firefox-esr \
		libxml2-utils \
		openssh-server \
		build-essential \
		libcanberra-gtk3-module && \
	# setup go(golang)
	curl -sL https://golang.org/dl/go1.17.3.linux-amd64.tar.gz -o /tmp/go1.17.3.linux-amd64.tar.gz && \
	tar -xzf /tmp/go1.17.3.linux-amd64.tar.gz -C /usr/local && \
	rm -rf /tmp/go1.17.3.linux-amd64.tar.gz && \
	# setup node & npm
	apt-get install -y --no-install-recommends \
		npm \
		nodejs && \
	# setup yarn
	npm install -g yarn 

COPY scripts $HOME/scripts

ENV HOME="/root" \
	LANG="en_US.utf8" \
	GOPATH="/root/go" \
	GOROOT="/usr/local/go" \
	PATH="$PATH:/usr/local/go/bin:/root/go/bin:/root/scripts"

RUN \
	for script in $(find $HOME/scripts/install -maxdepth 1 -type f -print | sort); \
	do \
		echo ${script} && \
		chmod u+x ${script} && \
		${script}; \
	done && \
	rm -rf $HOME/scripts/install && \
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