FROM debian:latest

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

ENV HOME ${HOME}

# up(date|grade), install essentials & installed/generated locales
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
		tar \
		curl \
		locales \
		ca-certificates && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

# go(golang)
ARG GO_VERSION=1.17.3
RUN curl -sL https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz -o /tmp/go${GO_VERSION}.linux-amd64.tar.gz && \
	tar -xzf /tmp/go${GO_VERSION}.linux-amd64.tar.gz -C /usr/local && \
	rm -rf go${GO_VERSION}.linux-amd64.tar.gz
ENV GOROOT /usr/local/go
ENV GOPATH /root/go
ENV PATH ${PATH}:${GOROOT}/bin:${GOPATH}/bin

# node, npm & yarn
RUN apt-get install -y --no-install-recommends \
		npm \
		nodejs && \
	npm install -g yarn 

# scripts
COPY scripts ${HOME}/scripts
COPY configurations.tar.gz /tmp/configurations.tar.gz

RUN for script in $(find ${HOME}/scripts/install -maxdepth 1 -type f -print | sort); \
	do \
		echo ${script} && \
		chmod u+x ${script} && \
		${script}; \
	done && \
	rm -rf ${HOME}/scripts/install && \
	chmod a+x ${HOME}/scripts/*

WORKDIR ${HOME}