FROM signedsecurity/toolkits-base-debian:v1.0.0

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

COPY configurations.tar.gz /tmp/configurations.tar.gz

RUN \
	# up(date|grade)
	apt-get update && \
	apt-get upgrade -y --allow-downgrades && \
	# install essentials
	apt-get install -y --no-install-recommends \
		jq \
		nmap \
		arjun \
		whois \
		python3 \
		libxss1 \
		masscan \
		whatweb \
		burpsuite \
		libpcap-dev \
		python3-pip \
		firefox-esr \
		libxml2-utils \
		libcanberra-gtk3-module && \
	# extract configurations
	tar -xzf /tmp/configurations.tar.gz -C /tmp && \
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
	PATH="$PATH:/usr/local/go/bin:/root/go/bin"

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