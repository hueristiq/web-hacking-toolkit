FROM debian:latest AS base

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

# up(date|grade) & install essentials
RUN apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y --no-install-recommends \
			ca-certificates \
			openssh-server \
			curl \
			git \
			zsh \
			tmux \
			vim

# ssh
RUN sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config && \
		sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
		sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh && \
		git clone https://github.com/zsh-users/zsh-autosuggestions.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
		chsh -s /bin/zsh
COPY dotfiles/.zshrc ${HOME}/.zshrc
COPY dotfiles/.zprofile ${HOME}/.zprofile

# tmux
RUN mkdir -p ${HOME}/.tmux/plugins && \
		git clone https://github.com/tmux-plugins/tpm.git ${HOME}/.tmux/plugins/tpm
COPY dotfiles/.tmux.conf ${HOME}/.tmux.conf
RUN chmod +x ${HOME}/.tmux/plugins/tpm/bin/install_plugins && \
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

# go(golang)
RUN curl -sL https://golang.org/dl/go1.17.2.linux-amd64.tar.gz -o /tmp/go1.17.2.linux-amd64.tar.gz && \
	tar -xzf /tmp/go1.17.2.linux-amd64.tar.gz -C /usr/local && \
	rm -rf go1.17.2.linux-amd64.tar.gz
ENV GOROOT /usr/local/go
ENV GOPATH /root/go
ENV PATH ${PATH}:${GOROOT}/bin:${GOPATH}/bin

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_17.x | bash && \
		apt install -y nodejs && \
		npm install -g yarn

# Add Kali Linux Repository
FROM base as builder

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y --no-install-recommends \
		ca-certificates \
		gnupg && \
		echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list && \
		curl -sL 'https://archive.kali.org/archive-key.asc' -o archive-key.asc && \
		apt-key add archive-key.asc && \
		rm -rf archive-key.asc

COPY preferences/apt/web-hacking-toolkit.pref /etc/apt/preferences.d/web-hacking-toolkit.pref

RUN apt-get update && \
	apt-get upgrade -y

# Install tool kit
FROM builder as web-hacking-toolkit

ARG HOME=/root
ARG DEBIAN_FRONTEND=noninteractive

ENV HOME ${HOME}

RUN apt-get install -y --no-install-recommends \
		xauth \
		apt-utils \
		tzdata \
		build-essential \
		gcc \
		iputils-ping \
		tar \
		unzip \
		openssh-server \
		wget \
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
		default-jre \
		burpsuite \
		firefox-esr

# install scripts
COPY scripts/install /tmp/install
RUN for script in $(find /tmp/install -maxdepth 1 -type f -print | sort); \
	do \
		echo ${script} && \
		chmod u+x ${script} && \
		${script}; \
	done && \
		rm -rf /tmp/install

# Use this section to try new installation scripts.
# All previous steps will be cached
#
# COPY install_dev /tmp/install_dev

# RUN chmod a+x /tmp/install_dev/*.bash && \
# 		for i in /tmp/install_dev/*.bash; do echo $i && $i; done

COPY scripts/bin ${HOME}/scripts

RUN chmod a+x ${HOME}/scripts/*

WORKDIR ${HOME}