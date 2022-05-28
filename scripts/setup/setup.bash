#!/usr/bin/env bash

CONFIGURATIONS="/tmp/configurations"

export DEBIAN_FRONTEND=noninteractive

echo -e " + up(date|grade)"

apt-get update && apt-get upgrade -qq -y

echo -e " + install essentials"

apt-get install -y -qq --no-install-recommends \
	tar \
	git \
	curl \
	wget \
	tree \
	unzip \
	xauth \
	libxss1 \
	apt-utils \
	p7zip-full \
	build-essential

echo -e " + install/generate locales"

apt-get install -y -qq --no-install-recommends locales
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

echo -e " + extract configuration"

7z x /tmp/configurations.7z -o/tmp 

echo -e " + System Setup"

echo -e " +++++ Terminal"

echo -e " +++++++++ Shell (zsh)"

if [ ! -x "$(command -v zsh)" ]
then
	apt-get install -y -qq zsh
fi

if [ "${SHELL}" != "$(which zsh)" ]
then
	chsh -s $(which zsh) ${USER}
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 

git clone https://github.com/zsh-users/zsh-autosuggestions.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

mv ${CONFIGURATIONS}/.zshrc ${HOME}/.zshrc
mv ${CONFIGURATIONS}/.zprofile ${HOME}/.zprofile
mv ${CONFIGURATIONS}/.hushlogin ${HOME}/.hushlogin

echo -e " +++++++++ Session Manager (tmux)"

if [ ! -x "$(command -v tmux)" ]
then
	apt-get install -y -qq tmux
fi

mv ${CONFIGURATIONS}/.tmux.conf ${HOME}/.tmux.conf

TMUX_PLUGINS="${HOME}/.tmux/plugins"

if [ ! -d ${TMUX_PLUGINS} ]
then
	mkdir -p ${TMUX_PLUGINS}
fi

git clone https://github.com/tmux-plugins/tpm.git ${TMUX_PLUGINS}/tpm

if [ -f ${TMUX_PLUGINS}/tpm/bin/install_plugins ]
then
	chmod +x ${TMUX_PLUGINS}/tpm/bin/install_plugins
	${TMUX_PLUGINS}/tpm/bin/install_plugins
fi

echo -e " +++++ Browser"

echo -e " +++++++++ chrome"

if [ ! -x "$(command -v google-chrome)" ]
then
	curl -sL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/google-chrome-stable_current_amd64.deb

	apt-get install -y -qq /tmp/google-chrome-stable_current_amd64.deb
fi

echo -e " +++++++++ firefox"

if [ ! -x "$(command -v firefox)" ]
then
	apt-get install -y -qq firefox-esr ca-certificates libcanberra-gtk3-module
fi

mv -f ${CONFIGURATIONS}/.mozilla ${HOME}/.mozilla

echo -e " +++++ Remote Connection"

echo -e " +++++++++ ssh"

if [ ! -x "$(command -v ssh)" ]
then
	apt-get install -y -qq openssh-server
fi

sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

echo -e " + Development"

echo -e " +++++ Text Editor"

echo -e " +++++++++ vim"

if [ ! -x "$(command -v vim)" ]
then
	apt-get install -y -qq vim
fi

VIM_DIR="${HOME}/.vim"
VIM_COLORS="${VIM_DIR}/colors"; mkdir -p ${VIM_COLORS}
VIM_BUNDLE="${VIM_DIR}/bundle"; mkdir -p ${VIM_BUNDLE}
VIM_AUTOLOAD="${VIM_DIR}/autoload"; mkdir -p ${VIM_AUTOLOAD}

curl -sL https://tpo.pe/pathogen.vim -o ${VIM_AUTOLOAD}/pathogen.vim
curl -sL https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/onedark.vim -o ${VIM_AUTOLOAD}/onedark.vim
curl -sL https://raw.githubusercontent.com/joshdick/onedark.vim/master/colors/onedark.vim -o ${VIM_COLORS}/onedark.vim
mkdir -p ${VIM_AUTOLOAD}/airline/themes
curl -sL https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/airline/themes/onedark.vim -o ${VIM_AUTOLOAD}/airline/themes/onedark.vim
git clone https://github.com/preservim/nerdtree.git ${VIM_BUNDLE}/nerdtree
git clone https://github.com/ryanoasis/vim-devicons.git ${VIM_BUNDLE}/vim-devicons
git clone https://github.com/vim-airline/vim-airline.git ${VIM_BUNDLE}/vim-airline
git clone https://github.com/airblade/vim-gitgutter.git ${VIM_BUNDLE}/vim-gitgutter
git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git ${VIM_BUNDLE}/nerdtree-git-plugin
git clone https://github.com/tpope/vim-fugitive.git ${VIM_BUNDLE}/vim-fugitive

mv ${CONFIGURATIONS}/.vimrc ${HOME}/.vim/vimrc

echo -e " + language|frameworks|runtime"

echo -e " +++++ go"

if [ ! -x "$(command -v go)" ]
then
	if [ ! -f /tmp/go1.18.linux-amd64.tar.gz ]
	then
		curl -sL https://golang.org/dl/go1.18.linux-amd64.tar.gz -o /tmp/go1.18.linux-amd64.tar.gz
	fi
	if [ -f /tmp/go1.18.linux-amd64.tar.gz ]
	then
		tar -xzf /tmp/go1.18.linux-amd64.tar.gz -C /usr/local
		rm -rf /tmp/go1.18.linux-amd64.tar.gz
	fi
fi

(grep -q "export PATH=\$PATH:/usr/local/go/bin" ~/.profile) || {
	echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
}
(grep -q "export PATH=\$PATH:\${HOME}/go/bin" ~/.profile) || {
	echo "export PATH=\$PATH:\${HOME}/go/bin" >> ~/.profile
}

source ~/.profile

echo -e " +++++ python3"

if [ ! -x "$(command -v python3)" ] || [ ! -x "$(command -v pip3)" ]
then
	apt-get install -y -qq python3 python3-dev python3-pip python3-venv
fi

echo -e " +++++ node, npm & yarn"

if [ ! -x "$(command -v node)" ] || [ ! -x "$(command -v pip3)" ]
then
	curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
	apt-get install -y -qq  nodejs
fi
if [ -x "$(command -v npm)" ]
then
	npm install -g npm@latest

	if [ ! -x "$(command -v yarn)" ]
	then
		npm install -g yarn
	fi
fi

echo -e " + Tools"

tools="${HOME}/tools"

if [ ! -d ${tools} ]
then
	mkdir -p ${tools}
fi

# echo -e " ++++ amass"

# go install -v github.com/OWASP/Amass/v3/...@latest

# echo -e " ++++ anew"

# go install -v github.com/tomnomnom/anew@latest

echo -e " ++++ arjun"

if [ ! -x "$(command -v arjun)" ]
then
	apt-get install -y -qq arjun
fi

echo -e " ++++ Burp Suite Community"

if [ ! -x "$(command -v burpsuite)" ]
then
	apt-get install -y -qq burpsuite
fi

mv ${CONFIGURATIONS}/.BurpSuite ${HOME}/.BurpSuite

echo -e " ++++ cdncheck"

go install -v github.com/enenumxela/cdncheck/cmd/cdncheck@latest

echo -e " ++++ commix"

apt-get install -y -qq commix

echo -e " ++++ crlfuzz"

go install -v github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest

# echo -e " ++++ crobat"

# go install github.com/cgboal/sonarsearch/cmd/crobat@latest

echo -e " ++++ curl"

if [ ! -x "$(command -v curl)" ]
then
	apt-get install -y -qq curl
fi

echo -e " ++++ dalfox"

go install -v github.com/hahwul/dalfox/v2@latest

echo -e " ++++ dnsutils (dig, nslookup...)"

if [ ! -x "$(command -v dig)" ]
then
	apt-get install -y -qq dnsutils
fi

echo -e " ++++ dnsvalidator"

git clone https://github.com/vortexau/dnsvalidator.git /tmp/dnsvalidator
cd /tmp/dnsvalidator
python3 setup.py install
cd -

echo -e " ++++ dnsx"

go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest

echo -e " ++++ dotdotpwn"

if [ ! -x "$(command -v dotdotpwn)" ]
then
	apt-get install -y -qq dotdotpwn
fi

echo -e " ++++ ffuf"

go install -v github.com/ffuf/ffuf@latest

# echo -e " ++++ findomain"

# curl -sL https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -o /usr/local/bin/findomain

# chmod +x /usr/local/bin/findomain

echo -e " ++++ gin"

pip3 install gin

echo -e " ++++ gowitness"

go install -v github.com/sensepost/gowitness@latest

# echo -e " ++++ gotator"

# go install github.com/Josue87/gotator@latest

echo -e " ++++  grep"

if [ ! -x "$(command -v grep)" ]
then
	apt-get install -y -qq grep
fi

# echo -e " ++++ hakrevdns"

# go install -v github.com/hakluke/hakrevdns@latest

# echo -e " ++++ httpx"

# go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

echo -e " ++++ jq"

if [ ! -x "$(command -v jq)" ]
then
	apt-get install -y -qq jq
fi

echo -e " ++++ kiterunner"

curl -sL https://github.com/assetnote/kiterunner/releases/download/v1.0.2/kiterunner_1.0.2_linux_arm64.tar.gz -o /tmp/kiterunner_1.0.2_linux_arm64.tar.gz
tar -xzf /tmp/kiterunner_1.0.2_linux_arm64.tar.gz -C /usr/local && \
rm -rf /tmp/kiterunner_1.0.2_linux_arm64.tar.gz

# echo -e " ++++ masscan"

# if [ ! -x "$(command -v masscan)" ]
# then
# 	apt-get install -y -qq masscan
# fi

# echo -e " ++++ massdns"

# if [ ! -x "$(command -v massdns)" ]
# then
# 	apt-get install -y -qq massdns
# fi

# echo -e " ++++ naabu"

# apt-get install -y -qq libpcap-dev
# go install -v github.com/projectdiscovery/naabu/cmd/naabu@latest

echo -e " ++++ net-tools"

if [ ! -x "$(command -v ifconfig)" ]
then
	apt-get install -y -qq net-tools
fi

# echo -e " ++++ nmap"

# if [ ! -x "$(command -v nmap)" ]
# then
# 	apt-get install -y -qq nmap
# fi

echo -e " ++++ nmap-utils"

curl -sL https://raw.githubusercontent.com/enenumxela/nmap-utils/main/merge-nmap-xml -o /usr/local/bin/merge-nmap-xml

curl -sL https://raw.githubusercontent.com/enenumxela/nmap-utils/main/parse-nmap-xml -o /usr/local/bin/parse-nmap-xml

chmod +x /usr/local/bin/merge-nmap-xml /usr/local/bin/parse-nmap-xml

# echo -e " ++++ nuclei"

# go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

echo -e " ++++ ping"

apt-get install -y -qq iputils-ping

echo -e " ++++ ps.sh"

curl -s https://raw.githubusercontent.com/enenumxela/ps.sh/main/install.sh | bash -

# echo -e " ++++ puredns"

# go install -v github.com/d3mondev/puredns/v2@latest

echo -e " ++++ sigrawl3r"

go install -v github.com/signedsecurity/sigrawl3r/cmd/sigrawl3r@latest

# echo -e " ++++ sigsubfind3r"

# go install -v github.com/signedsecurity/sigsubfind3r/cmd/sigsubfind3r@latest

echo -e " ++++ sigurlfind3r"

go install -v github.com/signedsecurity/sigurlfind3r/cmd/sigurlfind3r@latest

echo -e " ++++ sigurlscann3r"

go install -v github.com/signedsecurity/sigurlscann3r/cmd/sigurlscann3r@latest

echo -e " ++++ sqlmap"

apt-get install -y -qq sqlmap

echo -e " ++++ subdomains.sh"

curl -s https://raw.githubusercontent.com/enenumxela/subdomains.sh/main/install.sh | bash -

# echo -e " ++++ subfinder"

# go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

echo -e " ++++ urlx"

go install -v github.com/enenumxela/urlx/cmd/urlx@latest

echo -e " ++++ wafw00f"

if [ ! -x "$(command -v wafw00f)" ]
then
	apt-get install -y -qq wafw00f
fi

echo -e " ++++ wappalyzer"

git clone https://github.com/AliasIO/wappalyzer.git ${tools}/wappalyzer

if [ -d ${tools}/wappalyzer ]
then
	cd ${tools}/wappalyzer
	yarn install
	yarn run link
	cd -
fi

echo -e " ++++ whatweb"

if [ ! -x "$(command -v whatweb)" ]
then
	apt-get install -y -qq whatweb
fi

echo -e " ++++ whois"

if [ ! -x "$(command -v whois)" ]
then
	apt-get install -y -qq whois
fi

echo -e " ++++ wpscan"

if [ ! -x "$(command -v wpscan)" ]
then
	apt-get install -y -qq wpscan
fi

echo -e " ++++ wuzz"

go install -v github.com/asciimoo/wuzz@latest

echo -e " + Wordlists"

wordlists="${HOME}/wordlists"

if [ ! -d ${wordlists} ]
then
	mkdir -p ${wordlists}
fi

echo -e " ++++ WordlistsX"

git clone "https://github.com/enenumxela/wordlistsx.git" "${wordlists}/WordlistsX"

echo -e " + Clean UP"

rm -rf $HOME/scripts/setup

rm -rf /tmp/configurations*

for task in autoremove autoclean clean
do
	apt-get -y -qq ${task}
done

rm -rf /var/lib/apt/lists/*

go clean -cache 
go clean -testcache
go clean -modcache