FROM kalilinux/kali-rolling:latest

ARG HOME=/root

COPY scripts $HOME/scripts
COPY configurations.7z /tmp/configurations.7z

RUN \
	chmod +x $HOME/scripts/* $HOME/scripts/setup/* && \
	for script in $(find $HOME/scripts/setup -maxdepth 1 -type f -print | sort); \
	do \
		echo ${script} && \
		${script}; \
	done

WORKDIR $HOME