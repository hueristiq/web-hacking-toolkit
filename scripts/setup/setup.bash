#!/usr/bin/env bash

USER_LOCAL_BIN="${HOME}/.local/bin"

if [ ! -d ${USER_LOCAL_BIN} ]
then
	mkdir -p ${USER_LOCAL_BIN}
fi

CONFIGURATIONS="/tmp/configurations"

# {{ ssh

echo -e " + ssh"

apt-get install -y -qq openssh-server

sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# }} ssh
# {{ System 

echo -e " + System"

# {{ Terminal

echo -e " +++++ Terminal"

# {{ bash

echo -e " +++++++++ SHELL (bash)"

mv ${CONFIGURATIONS}/.bashrc ${HOME}/.bashrc
mv ${CONFIGURATIONS}/.hushlogin ${HOME}/.hushlogin

# }} bash
# {{ tmux

echo -e " +++++++++ Multiplexer (tmux)"

if [ ! -x "$(command -v tmux)" ]
then
	apt-get install -y -qq tmux
fi

mv ${CONFIGURATIONS}/.tmux.conf ${HOME}/.tmux.conf

TMUX_PLUGINS="${HOME}/.tmux/plugins"

mkdir -p ${TMUX_PLUGINS}

git clone https://github.com/tmux-plugins/tpm.git ${TMUX_PLUGINS}/tpm

if [ -f ${TMUX_PLUGINS}/tpm/bin/install_plugins ]
then
	chmod +x ${TMUX_PLUGINS}/tpm/bin/install_plugins
	${TMUX_PLUGINS}/tpm/bin/install_plugins
fi

# }} tmux

# }} Terminal
# {{ Text Editor

echo -e " +++++ Text Editor"

# {{ vim

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

# }} vim

# }} Text Editor
# {{ Browser 

echo -e " +++++ Browser"

# {{ chrome

echo -e " +++++++++ chrome"

curl -sL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/google-chrome-stable_current_amd64.deb

apt-get install -y -qq /tmp/google-chrome-stable_current_amd64.deb

# }} chrome
# {{ firefox

echo -e " +++++++++ firefox"

apt-get install -y -qq firefox-esr ca-certificates libcanberra-gtk3-module

mv -f ${CONFIGURATIONS}/.mozilla ${HOME}/.mozilla

# }} firefox

# }} Browser

# }} System
# {{ Tools

echo -e " + Tools"

tools="${HOME}/tools"

if [ ! -d ${tools} ]
then
	mkdir -p ${tools}
fi

echo -e " ++++ amass"

go install -v github.com/OWASP/Amass/v3/...@latest

echo -e " ++++ anew"

go install -v github.com/tomnomnom/anew@latest

echo -e " ++++ arjun"

apt-get install -y -qq arjun

echo -e " ++++ burpsuite"

apt-get install -y -qq burpsuite

echo -e " ++++ cdncheck"

go install -v github.com/enenumxela/cdncheck/cmd/cdncheck@latest

echo -e " ++++ commix"

apt-get install -y -qq commix

echo -e " ++++ crlfuzz"

go install -v github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest

echo -e " ++++ dalfox"

go install -v github.com/hahwul/dalfox/v2@latest

echo -e " ++++ dnsutils (dig, nslookup...)"

apt-get install -y -qq dnsutils

echo -e " ++++ dnsvalidator"

git clone https://github.com/vortexau/dnsvalidator.git /tmp/dnsvalidator
cd /tmp/dnsvalidator
python3 setup.py install
cd -

echo -e " ++++ dnsx"

go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest

echo -e " ++++ dotdotpwn"

apt-get install -y -qq dotdotpwn

echo -e " ++++ ffuf"

go install -v github.com/ffuf/ffuf@latest

echo -e " ++++ findomain"

file="/usr/local/bin/findomain"

curl -sL https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -o ${file}

if [ -f ${file} ]
then
	chmod u+x ${file}
fi

echo -e " ++++ gin"

pip3 install gin

echo -e " ++++  grep"

apt-get install -y -qq grep

echo -e " ++++ gowitness"

go install -v github.com/sensepost/gowitness@latest

echo -e " ++++ hakrevdns"

go install -v github.com/hakluke/hakrevdns@latest

echo -e " ++++ httpx"

go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

echo -e " ++++ jq"

apt-get install -y -qq jq

echo -e " ++++ kiterunner"

curl -sL https://github.com/assetnote/kiterunner/releases/download/v1.0.2/kiterunner_1.0.2_linux_arm64.tar.gz -o /tmp/kiterunner_1.0.2_linux_arm64.tar.gz
tar -xzf /tmp/kiterunner_1.0.2_linux_arm64.tar.gz -C /usr/local && \
rm -rf /tmp/kiterunner_1.0.2_linux_arm64.tar.gz

echo -e " ++++ masscan"

apt-get install -y -qq masscan

echo -e " ++++ massdns"

apt-get install -y -qq massdns

echo -e " ++++ naabu"

apt-get install -y -qq libpcap-dev
go install -v github.com/projectdiscovery/naabu/cmd/naabu@latest

echo -e " ++++ net-tools"

apt-get install -y -qq net-tools

echo -e " ++++ nmap"

apt-get install -y -qq nmap

echo -e " ++++ nuclei"

go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

echo -e " ++++ ping"

apt-get install -y -qq iputils-ping

echo -e " ++++ ps.sh"

curl -s https://raw.githubusercontent.com/enenumxela/ps.sh/main/install.sh | bash -

echo -e " ++++ puredns"

go install -v github.com/d3mondev/puredns/v2@latest

echo -e " ++++ sigrawl3r"

go install -v github.com/signedsecurity/sigrawl3r/cmd/sigrawl3r@latest

echo -e " ++++ sigsubfind3r"

go install -v github.com/signedsecurity/sigsubfind3r/cmd/sigsubfind3r@latest

echo -e " ++++ sigurlfind3r"

go install -v github.com/signedsecurity/sigurlfind3r/cmd/sigurlfind3r@latest

echo -e " ++++ sigurlscann3r"

go install -v github.com/signedsecurity/sigurlscann3r/cmd/sigurlscann3r@latest

echo -e " ++++ sqlmap"

apt-get install -y -qq sqlmap

echo -e " ++++ subdomains.sh"

curl -s https://raw.githubusercontent.com/enenumxela/subdomains.sh/main/install.sh | bash -

echo -e " ++++ subfinder"

go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

echo -e " ++++ urlx"

go install -v github.com/enenumxela/urlx/cmd/urlx@latest

echo -e " ++++ wafw00f"

apt-get install -y -qq wafw00f

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

apt-get install -y -qq whatweb

echo -e " ++++ whois"

apt-get install -y -qq whois

echo -e " ++++ wpscan"

apt-get install -y -qq wpscan

echo -e " ++++ wuzz"

go install -v github.com/asciimoo/wuzz@latest

# }} Tools
# {{ Wordlists

echo -e " + Wordlists"

wordlists="${HOME}/wordlists"

if [ ! -d ${wordlists} ]
then
	mkdir -p ${wordlists}
fi

echo -e " ++++ blechschmidt's massdns resolvers.txt"

curl -sL https://raw.githubusercontent.com/blechschmidt/massdns/master/lists/resolvers.txt -o ${wordlists}/resolvers.txt

echo -e " ++++ leaky-paths"

curl -sL https://raw.githubusercontent.com/ayoubfathi/leaky-paths/main/leaky-paths.txt -o ${wordlists}/leaky-paths.txt

echo -e " ++++ permutations"

curl -sL https://gist.githubusercontent.com/six2dez/ffc2b14d283e8f8eff6ac83e20a3c4b4/raw/df5ef9e898fa4598e83263925f49d6fe6242ddf1/permutations_list.txt -o ${wordlists}/permutations.txt

echo -e " ++++ SecLists"

git clone https://github.com/danielmiessler/SecLists.git ${wordlists}/SecLists

# }} Wordlists