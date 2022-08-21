FROM kalilinux/kali-rolling:latest

LABEL org.heuristiq.image.authors="Alex Munene (enenumxela)"

ARG HOME=/root
ARG TOOLS=${HOME}/TOOLS
ARG LOCALBIN=${HOME}/.local/bin
ARG WHT=/etc/web-hacking-toolkit

ARG DEBIAN_FRONTEND=noninteractive

ENV \
	WHT=${WHT} \
	HOME=${HOME} \
	TOOLS=${TOOLS} \
	LOCALBIN=${LOCALBIN}

RUN \
	# up(date|grade)
	apt-get update && \
	apt-get upgrade -qq -y && \
	# create a folder in /etc to store compressed files
	if [ ! -d ${WHT} ];\
	then \
		mkdir -p ${WHT};\
	fi && \
	if [ ! -d ${TOOLS} ];\
	then \
		mkdir -p ${TOOLS};\
	fi && \
	if [ ! -d ${LOCALBIN} ];\
	then \
		mkdir -p ${LOCALBIN};\
	fi

# copy the files
COPY scripts.7z ${WHT}/scripts.7z 
COPY configurations.7z ${WHT}/configurations.7z

RUN \
	# install p7zip-full
	apt-get install -y -qq --no-install-recommends \
		p7zip-full && \
	# p7zip extract scripts
	7z x ${WHT}/scripts.7z -o/tmp  && \
	# run setup
	for script in $(find /tmp/scripts -maxdepth 1 -type f -name "*-setup*" -print | sort); \
	do \
		echo ${script}; \
		chmod +x ${script}; \
		${script}; \
	done && \
	# make scrips executable
	chmod +x /tmp/scripts/* && \
	# move scripts to user bin
	mv -f /tmp/scripts/* ${LOCALBIN}

WORKDIR $HOME