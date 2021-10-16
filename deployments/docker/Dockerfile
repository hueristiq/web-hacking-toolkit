FROM ubuntu:21.04

LABEL maintainer="Alex Munene (@enenumxela)"

ARG HOME=/root
ENV HOME ${HOME}

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR ${HOME}

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
		apt-utils \
		tzdata \
		build-essential \
		gcc \
		iputils-ping \
		wget \
		git \
		unzip \
		openssh-server \
		curl \
		tmux \
		zsh \
		make \
		nmap \
		whois \
		python3 \
		python3-pip \
		dnsutils \
		net-tools \
		tree \
		jq \
		libpcap-dev \
		default-jre 

RUN ln -fs /usr/share/zoneinfo/Africa/Nairobi /etc/localtime && \
		dpkg-reconfigure --frontend noninteractive tzdata

COPY install /tmp/install

RUN chmod a+x /tmp/install/*.bash && \
		for i in /tmp/install/*.bash; do echo $i && $i; done

COPY scripts ${HOME}/scripts

RUN chmod a+x ${HOME}/scripts/*