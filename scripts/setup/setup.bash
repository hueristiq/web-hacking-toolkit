#!/usr/bin/env bash

tools="${HOME}/tools"

if [ ! -d ${tools} ]
then
	mkdir -p ${tools}
fi

USER_LOCAL_BIN="${HOME}/.local/bin"
CONFIGURATIONS="/tmp/configurations"

if [ ! -d ${USER_LOCAL_BIN} ]
then
	mkdir -p ${USER_LOCAL_BIN}
fi

# {{ ssh

echo -e " + ssh"

apt-get install -y -qq openssh-server

sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# }} ssh
# {{ System 

echo -e " + Terminal"

# {{ Terminal

echo -e " +++++ Terminal"

# {{ bash

echo -e " +++++++++ SHELL (bash)"

mv ${CONFIGURATIONS}/.bashrc ${HOME}/.bashrc

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

# {{ Swiss Army-Knife

echo -e " +++++ Swiss Army-Knife"

# {{ burpsuite

echo -e " +++++++++ burpsuite"

apt-get install -y -qq burpsuite

# }} burpsuite

# }} Swiss Army-Knife
# {{ Discovery

echo -e " +++++ Discovery"

# {{ WHOIS

echo -e " +++++++++ WHOIS"

# {{ whois

echo -e " +++++++++++++ whois"

apt-get install -y -qq whois

# }} whois

# }} WHOIS
# {{ Domain

echo -e " +++++++++ Domain"

# {{ amass

echo -e " +++++++++++++ amass"

go install github.com/OWASP/Amass/v3/...@latest

# }} amass
# {{ subfinder

echo -e " +++++++++++++ subfinder"

go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# }} subfinder
# {{ findomain

echo -e " +++++++++++++ findomain"

file="/usr/local/bin/findomain"

curl -sL https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -o ${file}

if [ -f ${file} ]
then
	chmod u+x ${file}
fi

# }} findomain
# {{ sigsubfind3r

echo -e " +++++++++++++ sigsubfind3r"

go install github.com/signedsecurity/sigsubfind3r/cmd/sigsubfind3r@latest

# }} sigsubfind3r
# {{ subdomains.sh

echo -e " +++++++++++++ subdomains.sh"

curl -s https://raw.githubusercontent.com/enenumxela/subdomains.sh/main/install.sh | bash -

# file="${USER_LOCAL_BIN}/subdomains.sh"

# curl -sL https://raw.githubusercontent.com/enenumxela/subdomains.sh/main/subdomains.sh -o ${file}

# if [ -f ${file} ]
# then
# 	chmod u+x ${file}
# fi

# }} subdomains.sh

# }} Domain
# {{ DNS

echo -e " +++++++++ DNS"

# {{ dnsx

echo -e " +++++++++++++ dnsx"

go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest

# }} dnsx
# {{ massdns

echo -e " +++++++++++++ massdns"

apt-get install -y -qq massdns

# }} massdns
# {{ hakrevdns

echo -e " +++++++++++++ hakrevdns"

go install github.com/hakluke/hakrevdns@latest

# }} hakrevdns

# }} DNS
# {{ PORT

echo -e " +++++++++ PORT"

# {{ nmap

echo -e " +++++++++++++ nmap"

apt-get install -y -qq nmap

# }} nmap
# {{ naabu

echo -e " +++++++++++++ naabu"

apt-get install -y -qq libpcap-dev
go install github.com/projectdiscovery/naabu/cmd/naabu@latest

# }} naabu
# {{ masscan

echo -e " +++++++++++++ masscan"

apt-get install -y -qq masscan

# }} masscan
# {{ ps.sh

echo -e " +++++++++++++ ps.sh"

curl -s https://raw.githubusercontent.com/enenumxela/ps.sh/main/install.sh | bash -


# apt-get install -y -qq libxml2-utils

# file="${USER_LOCAL_BIN}/ps.sh"

# curl -sL https://raw.githubusercontent.com/enenumxela/ps.sh/main/ps.sh -o ${file}

# if [ -f ${file} ]
# then
# 	chmod u+x ${file}
# fi

# }} ps.sh

# }} PORT
# {{ Technologies

echo -e " +++++++++ Technologies"

# {{ wafw00f

echo -e " +++++++++++++ wafw00f"

apt-get install -y -qq wafw00f

# }} wafw00f
# {{ whatweb

echo -e " +++++++++++++ whatweb"

apt-get install -y -qq whatweb

# }} whatweb
# {{ wappalyzer

echo -e " +++++++++++++ wappalyzer"

git clone https://github.com/AliasIO/wappalyzer.git ${tools}/wappalyzer

if [ -d ${tools}/wappalyzer ]
then
	cd ${tools}/wappalyzer
	yarn install
	yarn run link
	cd -
fi

# }} wappalyzer

# }} Technologies
# }} URL

echo -e " +++++++++ URL"

# {{ sigurlfind3r

echo -e " +++++++++++++ sigurlfind3r"

go install github.com/signedsecurity/sigurlfind3r/cmd/sigurlfind3r@latest

# }} sigurlfind3r

# }} URL
# }} Parameters

echo -e " +++++++++ Parameters"

# {{ arjun

echo -e " +++++++++++++ arjun"

apt-get install -y -qq arjun

# }} arjun

# }} Parameters
# }} Fuzz

echo -e " +++++++++ Fuzz"

# {{ ffuf

echo -e " +++++++++++++ ffuf"

go install github.com/ffuf/ffuf@latest

# }} ffuf

# }} Fuzz
# }} Content

echo -e " +++++++++ Content"

# {{ kiterunner

echo -e " +++++++++++++ kiterunner"

curl -sL https://github.com/assetnote/kiterunner/releases/download/v1.0.2/kiterunner_1.0.2_linux_arm64.tar.gz -o /tmp/kiterunner_1.0.2_linux_arm64.tar.gz
tar -xzf /tmp/kiterunner_1.0.2_linux_arm64.tar.gz -C /usr/local && \
rm -rf /tmp/kiterunner_1.0.2_linux_arm64.tar.gz && \

# }} kiterunner

# }} Content

# }} Discovery
# {{ Scanner

echo -e " +++++ Scanner"

echo -e " +++++++++ Army-Knife"

# {{ nuclei

echo -e " +++++++++++++ nuclei"

go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

# }}
# {{ sigurlscann3r

echo -e " +++++++++++++ sigurlscann3r"

go install github.com/signedsecurity/sigurlscann3r/cmd/sigurlscann3r@latest

# }}

echo -e " +++++++++ Wordpress"

# {{ wprecon

echo -e " +++++++++++++ wprecon"

file="/usr/local/bin/wprecon"

curl -sL https://github.com/blackcrw/wprecon/releases/latest/download/wprecon-linux -o ${file}

if [ -f ${file} ]
then
	chmod u+x ${file}
fi

# }} wprecon
# {{ wpscan

echo -e " +++++++++++++ wpscan"

apt-get install -y -qq wpscan

# }} wpscan

echo -e " +++++++++ Command Injection"

# {{ commix

echo -e " +++++++++++++ commix"

apt-get install -y -qq commix

# }} commix

echo -e " +++++++++ SQL Injection"

# {{ sqlmap

echo -e " +++++++++++++ sqlmap"

apt-get install -y -qq sqlmap

# }} sqlmap

echo -e " +++++++++ Cross Site Scripting"

# {{ dalfox

echo -e " +++++++++++++ dalfox"

go install github.com/hahwul/dalfox/v2@latest

# }} dalfox

echo -e " +++++++++ CRLF Injection"

# {{ crlfuzz

echo -e " +++++++++++++ crlfuzz"

go install github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest

# }} crlfuzz

echo -e " +++++++++ Directory Traversal"

# {{ dotdotpwn

echo -e " +++++++++++++ dotdotpwn"

apt-get install -y -qq dotdotpwn

# }} dotdotpwn

# }} Scanner
# {{ Utilities

echo -e " +++++ Utilities"

# {{ DNS

echo -e " +++++++++ DNS"

# {{ dnsutils (dig, nslookup...)

echo -e " +++++++++++++ dnsutils (dig, nslookup...)"

apt-get install -y -qq dnsutils

# }} dnsutils (dig, nslookup...)

# }} DNS
# {{ Screenshot

echo -e " +++++++++ Screenshot"

# {{ gowitness

echo -e " +++++++++++++ gowitness"

go install github.com/sensepost/gowitness@latest

# }} gowitness

# }} Screenshot
# {{ JSON 

echo -e " +++++++++ JSON"

# {{ jq

echo -e " +++++++++++++ jq"

apt-get install -y -qq jq

# }} jq

# }} JSON
# {{ URL 

echo -e " +++++++++ URL"

# {{ urlx

echo -e " +++++++++++++ urlx"

go install github.com/enenumxela/urlx/cmd/urlx@latest

# }} urlx

# }} URL
# {{ CDN

echo -e " +++++++++ CDN"

# {{ cdncheck

echo -e " +++++++++++++ cdncheck"

go install github.com/enenumxela/cdncheck/cmd/cdncheck@latest

# }} cdncheck

# }} CDN
# {{ tee 

echo -e " +++++++++ tee"

# {{ anew

echo -e " +++++++++++++ anew"

go install github.com/tomnomnom/anew@latest

# }} anew

# }} tee
# {{ HTTP 

echo -e " +++++++++ HTTP"

# {{ wuzz

echo -e " +++++++++++++ wuzz"

go install github.com/asciimoo/wuzz@latest

# }} wuzz
# {{ httpx

echo -e " +++++++++++++ httpx"

go install github.com/projectdiscovery/httpx/cmd/httpx@latest

# }}

# }} HTTP
# {{ Netrworking

echo -e " +++++++++ Netrworking"

# {{ ping

echo -e " +++++++++++++ ping"

apt-get install -y -qq iputils-ping

# }} ping
# {{ net-tools

echo -e " +++++++++++++ net-tools"

apt-get install -y -qq net-tools

# }} net-tools

# }} Netrworking

# }} Utilities

# }} Tools
# {{ Wordlists

echo -e " + Wordlists"

wordlists="${HOME}/wordlists"

if [ ! -d ${wordlists} ]
then
	mkdir -p ${wordlists}
fi

# {{ blechschmidt's massdns resolvers.txt

echo -e " +++++ blechschmidt's massdns resolvers.txt"

curl -sL https://raw.githubusercontent.com/blechschmidt/massdns/master/lists/resolvers.txt -o ${wordlists}/resolvers.txt

# }} blechschmidt's massdns resolvers.txt
# {{ Assetnote

echo -e " +++++ Assetnote"

cd ${wordlists}

wget -r --no-parent -R "index.html*" https://wordlists-cdn.assetnote.io/data/ -nH
mv -rf data Assetnote

cd -

# }} Assetnote
# {{ SecLists

echo -e " +++++ SecLists"

git clone https://github.com/danielmiessler/SecLists.git ${wordlists}/SecLists

# }} SecLists

# }} Wordlists