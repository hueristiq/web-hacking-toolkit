FROM debian:latest

LABEL maintainer="Alex Munene"

ARG HOME=/root
ENV HOME ${HOME}

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR ${HOME}

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
		xauth \
		apt-utils \
		tzdata \
		build-essential \
		gcc \
		iputils-ping \
		wget \
		git \
		vim \
		tar \
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

COPY scripts/install /tmp/install

RUN for script in $(find /tmp/install -maxdepth 1 -type f -print); \
	do \
		echo ${script} && \
		chmod u+x ${script} && \
		${script}; \
	done

# Use this section to try new installation scripts.
# All previous steps will be cached
#
# COPY install_dev /tmp/install_dev

# RUN chmod a+x /tmp/install_dev/*.bash && \
# 		for i in /tmp/install_dev/*.bash; do echo $i && $i; done

COPY scripts/bin ${HOME}/scripts

RUN chmod a+x ${HOME}/scripts/*