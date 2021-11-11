FROM debian:latest

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

ENV HOME ${HOME}

# up(date|grade), install essentials & install/generate locales
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
		tar \
		curl \
		gnupg \
		locales \
		ca-certificates && \
	rm -rf /var/lib/apt/lists/* && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

# copy & extract configurations
COPY configurations.tar.gz /tmp/configurations.tar.gz
RUN tar -xzf /tmp/configurations.tar.gz -C /tmp

# add kali linux repository, up(date|grade)
RUN echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list && \
	curl -sL 'https://archive.kali.org/archive-key.asc' -o archive-key.asc && \
	apt-key add archive-key.asc && \
	rm -rf archive-key.asc && \
	mv /tmp/configurations/apt/web-hacking-toolkit.pref /etc/apt/preferences.d/web-hacking-toolkit.pref && \
	apt-get update && \
	apt-get upgrade -y --allow-downgrades && \
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
		burpsuite \
		net-tools \
		libpcap-dev \
		python3-pip \
		firefox-esr \
		openssh-server \
		build-essentials \
		libcanberra-gtk3-module

# setup go(golang)
RUN curl -sL https://golang.org/dl/go1.17.3.linux-amd64.tar.gz -o /tmp/go1.17.3.linux-amd64.tar.gz && \
	tar -xzf /tmp/go1.17.3.linux-amd64.tar.gz -C /usr/local && \
	rm -rf /tmp/go1.17.3.linux-amd64.tar.gz
ENV GOROOT /usr/local/go
ENV GOPATH /root/go
ENV PATH ${PATH}:${GOROOT}/bin:${GOPATH}/bin

# setup node, npm & yarn
RUN apt-get install -y --no-install-recommends \
		npm \
		nodejs && \
	npm install -g yarn 

# scripts
COPY scripts ${HOME}/scripts
RUN for script in $(find ${HOME}/scripts/install -maxdepth 1 -type f -print | sort); \
	do \
		echo ${script} && \
		chmod u+x ${script} && \
		${script}; \
	done && \
	rm -rf ${HOME}/scripts/install && \
	chmod a+x ${HOME}/scripts/*

# run clean up
RUN for task in autoremove autoclean clean; \
	do \
		apt-get -y -qq ${task}; \
	done && \
	rm -rf /tmp/configurations* && \
	rm -rf /var/lib/apt/lists/*

WORKDIR ${HOME}