FROM debian:latest

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

ENV HOME ${HOME}

COPY scripts ${HOME}/scripts
COPY configurations.tar.gz /tmp/configurations.tar.gz

RUN apt-get update && \
	apt-get upgrade -y && \
	for script in $(find ${HOME}/scripts/install -maxdepth 1 -type f -print | sort); \
	do \
		echo ${script} && \
		chmod u+x ${script} && \
		${script}; \
	done && \
	rm -rf ${HOME}/scripts/install && \
	chmod a+x ${HOME}/scripts/* && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

WORKDIR ${HOME}