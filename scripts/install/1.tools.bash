#!/usr/bin/env bash

CONFIGURATIONS="/tmp/configurations"

# {{ ssh

echo -e " + ssh"

sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# }}
# {{ bash

echo -e " + bash"

mv ${CONFIGURATIONS}/.bashrc ${HOME}/.bashrc

# }}
# {{ tmux

echo -e " + tmux"

mv ${CONFIGURATIONS}/.tmux.conf ${HOME}/.tmux.conf

TMUX_PLUGINS="${HOME}/.tmux/plugins"

mkdir -p ${TMUX_PLUGINS}

git clone https://github.com/tmux-plugins/tpm.git ${TMUX_PLUGINS}/tpm

if [ -f ${TMUX_PLUGINS}/tpm/bin/install_plugins ]
then
    chmod +x ${TMUX_PLUGINS}/tpm/bin/install_plugins
    ${TMUX_PLUGINS}/tpm/bin/install_plugins
fi

# }}
# {{ vim

echo -e " + vim"

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

# }}

tools="${HOME}/tools"

mkdir -p ${tools}

# {{ firefox

echo -e " + firefox"

mv ${CONFIGURATIONS}/mozilla ${HOME}/.mozilla

# }}
# {{ anew

echo -e " + anew"

go install github.com/tomnomnom/anew@latest

# }}
# {{ wuzz

echo -e " + wuzz"

go install github.com/asciimoo/wuzz@latest

# }}
# {{ amass

echo -e " + amass"

go install github.com/OWASP/Amass/v3/...@latest

# }}
# {{ subfinder

echo -e " + subfinder"

go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# }}
# {{ findomain

echo -e " + findomain"

file="/usr/local/bin/findomain"

curl -sL https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -o ${file}

if [ -f ${file} ]
then
    chmod u+x ${file}
fi

# }}
# {{ sigsubfind3r

echo -e " + sigsubfind3r"

go install github.com/signedsecurity/sigsubfind3r/cmd/sigsubfind3r@latest

# }}
# {{ sigurlfind3r

echo -e " + sigurlfind3r"

go install github.com/signedsecurity/sigurlfind3r/cmd/sigurlfind3r@latest

# }}
# {{ sigurlscann3r

echo -e " + sigurlscann3r"

go install github.com/signedsecurity/sigurlscann3r/cmd/sigurlscann3r@latest

# }}
# {{ subdomains.sh

echo -e " + subdomains.sh"

file="/usr/local/bin/subdomains.sh"

curl -sL https://raw.githubusercontent.com/enenumxela/subdomains.sh/main/subdomains.sh -o ${file}

if [ -f ${file} ]
then
    chmod u+x ${file}
fi

# }}
# {{ dnsx

echo -e " + dnsx"

go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest

# }}
# {{ httpx

echo -e " + httpx"

go install github.com/projectdiscovery/httpx/cmd/httpx@latest

# }}
# {{ nuclei

echo -e " + nuclei"

go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

# }}
# {{ naabu

echo -e " + naabu"

go install github.com/projectdiscovery/naabu/cmd/naabu@latest

# }}
# {{ ps.sh

echo -e " + ps.sh"

file="/usr/local/bin/ps.sh"

curl -sL https://raw.githubusercontent.com/enenumxela/ps.sh/main/ps.sh -o ${file}

if [ -f ${file} ]
then
    chmod u+x ${file}
fi

# }}
# {{ ffuf

echo -e " + ffuf"

go install github.com/ffuf/ffuf@latest

# }}
# {{ html-tool

echo -e " + html-tool"

go install github.com/tomnomnom/hacks/html-tool@latest

# }}
# {{ wappalyzer

echo -e " + wappalyzer"

git clone https://github.com/AliasIO/wappalyzer.git ${tools}/wappalyzer

if [ -d ${tools}/wappalyzer ]
then
    cd ${tools}/wappalyzer
    yarn install
    yarn run link
    cd -
fi

# }}
# {{ gowitness

echo -e " + gowitness"

go install github.com/sensepost/gowitness@latest

# }}
# {{ urlx

echo -e " + urlx"

go install github.com/enenumxela/urlx/cmd/urlx@latest

# }}
# {{ hakrevdns

echo -e " + hakrevdns"

go install github.com/hakluke/hakrevdns@latest

# }}