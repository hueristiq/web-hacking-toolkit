FROM debian:latest

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

ENV HOME ${HOME}

COPY scripts/install /tmp/install
COPY scripts/bin ${HOME}/scripts
COPY preferences/apt/web-hacking-toolkit.pref /etc/apt/preferences.d/web-hacking-toolkit.pref

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
		curl \
		gnupg \
		ca-certificates && \
	echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list && \
	curl -sL 'https://archive.kali.org/archive-key.asc' -o archive-key.asc && \
	apt-key add archive-key.asc && \
	rm -rf archive-key.asc && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
		jq \
		git \
		tar \
		vim \
		npm \
		tmux \
		wget \
		nmap \
		tree \
		unzip \
		xauth \
		whois \
		nodejs \
		locales \
		python3 \
		burpsuite \
		net-tools \
		libpcap-dev \
		python3-pip \
		firefox-esr \
		openssh-server \
		libcanberra-gtk3-module && \
	npm install -g yarn && \
	for script in $(find /tmp/install -maxdepth 1 -type f -print | sort); \
	do \
		echo ${script} && \
		chmod u+x ${script} && \
		${script}; \
	done && \
	rm -rf /tmp/install && \
	chmod a+x ${HOME}/scripts/* && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

# ssh
RUN sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config && \
	sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# bash
COPY dotfiles/.bashrc ${HOME}/.bashrc

# tmux
COPY dotfiles/.tmux.conf ${HOME}/.tmux.conf
RUN mkdir -p ${HOME}/.tmux/plugins && \
	git clone https://github.com/tmux-plugins/tpm.git ${HOME}/.tmux/plugins/tpm && \
	chmod +x ${HOME}/.tmux/plugins/tpm/bin/install_plugins && \
	${HOME}/.tmux/plugins/tpm/bin/install_plugins

# vim
RUN mkdir -p ${HOME}/.vim/colors && \
	mkdir -p ${HOME}/.vim/bundle && \
	mkdir -p ${HOME}/.vim/autoload && \
	curl -sL https://tpo.pe/pathogen.vim -o ${HOME}/.vim/autoload/pathogen.vim && \
	curl -sL https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/onedark.vim -o ${HOME}/.vim/autoload/onedark.vim && \
	curl -sL https://raw.githubusercontent.com/joshdick/onedark.vim/master/colors/onedark.vim -o ${HOME}/.vim/colors/onedark.vim && \
	mkdir -p ${HOME}/.vim/autoload/airline/themes && \
	curl -sL https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/airline/themes/onedark.vim -o ${HOME}/.vim/autoload/airline/themes/onedark.vim && \
	git clone https://github.com/preservim/nerdtree.git ${HOME}/.vim/bundle/nerdtree && \
	git clone https://github.com/ryanoasis/vim-devicons.git ${HOME}/.vim/bundle/vim-devicons && \
	git clone https://github.com/vim-airline/vim-airline.git ${HOME}/.vim/bundle/vim-airline && \
	git clone https://github.com/airblade/vim-gitgutter.git ${HOME}/.vim/bundle/vim-gitgutter && \
	git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git ${HOME}/.vim/bundle/nerdtree-git-plugin && \
	git clone https://github.com/tpope/vim-fugitive.git ${HOME}/.vim/bundle/vim-fugitive
COPY dotfiles/.vimrc ${HOME}/.vim/vimrc

WORKDIR ${HOME}