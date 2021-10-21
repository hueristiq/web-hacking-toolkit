#!/usr/bin/env bash

script_location="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

mkdir -p ~/.config

git_clone() {
	if [ -d ${2} ]
	then
		git -C ${2} pull &> /dev/null
	else
		git clone ${1} ${2} &> /dev/null
	fi
}

# {{ zsh

echo -e " + zsh"

if [ ! -x "$(command -v zsh)" ]
then
	apt -y -qq install zsh &> /dev/null
fi

if [ "${SHELL}" != "$(which zsh)" ]
then
	chsh -s $(which zsh) ${USER}
fi

# ohmyzsh
curl -sL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o /tmp/install.sh
chmod u+x /tmp/install.sh
/tmp/install.sh &> /dev/null

# zsh-autosuggestions
git_clone "https://github.com/zsh-users/zsh-autosuggestions" "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
# zsh-syntax-highlighting
git_clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

cp -f ${script_location}/dotfiles/.zshrc ${HOME}/.zshrc
cp -f ${script_location}/dotfiles/.zprofile ${HOME}/.zprofile

# }}
# {{ tmux

echo -e " + tmux"

if [ ! -x "$(command -v tmux)" ]
then
	apt -y -qq install tmux &> /dev/null
fi

cp -f ${script_location}/dotfiles/.tmux.conf ${HOME}/.tmux.conf

directory="${HOME}/.tmux/plugins"; [ ! -d ${directory} ] && mkdir -p ${directory}

git_clone "https://github.com/tmux-plugins/tpm" "${directory}/tpm"

chmod u+x ${directory}/tpm/bin/install_plugins

${directory}/tpm/bin/install_plugins &> /dev/null

# }}
# {{ vim

# echo -e " + vim"

# [ ! -x "$(command -v vim)" ] && {
# 	apt -y -qq install vim &> /dev/null
# }

# directory="${HOME}/.vim"
# [ ! -d ${directory}/colors ] && mkdir -p ${directory}/colors
# [ ! -d ${directory}/bundle ] && mkdir -p ${directory}/bundle
# [ ! -d ${directory}/autoload ] && mkdir -p ${directory}/autoload

# [ -e "${directory}/autoload/pathogen.vim" ] && rm -rf ${directory}/autoload/pathogen.vim
# curl -sL https://tpo.pe/pathogen.vim -o ${directory}/autoload/pathogen.vim

# [ -e "${directory}/autoload/onedark.vim" ] && {
# 	rm -rf ${directory}/autoload/onedark.vim
# }
# curl -sL https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/onedark.vim -o ${directory}/autoload/onedark.vim

# [ -e "${directory}/colors/onedark.vim" ] && {
# 	rm -rf ${directory}/colors/onedark.vim
# }
# curl -sL https://raw.githubusercontent.com/joshdick/onedark.vim/master/colors/onedark.vim -o ${directory}/colors/onedark.vim

# [ ! -e "${directory}/autoload/airline/themes" ] && {
# 	mkdir -p ${directory}/autoload/airline/themes
# }
# [ -e "${directory}/autoload/airline/themes/onedark.vim" ] && {
# 	rm -rf ${directory}/autoload/airline/themes/onedark.vim
# }
# curl -sL https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/airline/themes/onedark.vim -o ${directory}/autoload/airline/themes/onedark.vim

# git_clone "https://github.com/preservim/nerdtree.git" "${directory}/bundle/nerdtree"
# git_clone "https://github.com/ryanoasis/vim-devicons.git" "${directory}/bundle/vim-devicons"
# git_clone "https://github.com/vim-airline/vim-airline.git" "${directory}/bundle/vim-airline"
# git_clone "https://github.com/airblade/vim-gitgutter.git" "${directory}/bundle/vim-gitgutter"
# git_clone "https://github.com/Xuyuanp/nerdtree-git-plugin.git" "${directory}/bundle/nerdtree-git-plugin"
# git_clone "https://github.com/tpope/vim-fugitive.git" "${directory}/bundle/vim-fugitive"

# cp -f ${script_location}/dotfiles/.vimrc ${HOME}/.vim/vimrc

# }}
# {{ node

# echo -e " + node"

# [ ! -x "$(command -v nvm)" ] && {
# 	curl -sSL https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash - &> /dev/null
	

# 	export NVM_DIR="$HOME/.nvm"
# 	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# 	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# 	source ${HOME}/.bashrc

# 	nvm install node &> /dev/null
# }

# }}
# {{ golang

# echo -e " + golang"

# [ ! -x "$(command -v go)" ] && {
# 	version=1.17.1

# 	wget --quiet https://golang.org/dl/go${version}.linux-amd64.tar.gz -O /tmp/go${version}.linux-amd64.tar.gz &> /dev/null

# 	tar -xzf /tmp/go${version}.linux-amd64.tar.gz -C /usr/local

# 	(grep -q "export PATH=\$PATH:/usr/local/go/bin" ~/.profile) || {
# 		export PATH=$PATH:/usr/local/go/bin
# 		echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
# 		source ~/.profile
# 	}
# }

# }}

# tools="${HOME}/tools"; [ ! -d ${tools} ] && mkdir -p ${tools};

# {{ anew

# echo -e " + anew"

# export GOPATH=${tools}/anew
# go install github.com/tomnomnom/anew@latest &> /dev/null
# ln -sf ${tools}/anew/bin/anew /usr/local/bin/anew

# }}
# {{ wuzz

# echo -e " + wuzz"

# export GOPATH=${tools}/wuzz
# go install github.com/asciimoo/wuzz@latest &> /dev/null
# ln -sf ${tools}/wuzz/bin/wuzz /usr/local/bin/wuzz

# }}
# {{ amass

# echo -e " + amass"

# export GOPATH=${tools}/amass
# go install github.com/OWASP/Amass/v3/...@latest &> /dev/null
# ln -sf ${tools}/amass/bin/amass /usr/local/bin/amass

# }}
# {{ subfinder

# echo -e " + subfinder"

# export GOPATH=${tools}/subfinder
# go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest &> /dev/null
# ln -sf ${tools}/subfinder/bin/subfinder /usr/local/bin/subfinder

# cp -rf ${script_location}/dotfiles/.config/subfinder ${HOME}/.config/subfinder

# }}
# {{ findomain

# echo -e " + findomain"

# file="${tools}/findomain"; [ -e ${file} ] && rm -rf ${file};
# curl -sL https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -o ${tools}/findomain
# chmod u+x ${tools}/findomain
# ln -sf ${tools}/findomain /usr/local/bin/findomain

# }}
# {{ sigsubfind3r

# echo -e " + sigsubfind3r"

# export GOPATH=${tools}/sigsubfind3r
# go install github.com/signedsecurity/sigsubfind3r/cmd/sigsubfind3r@latest &> /dev/null
# ln -sf ${tools}/sigsubfind3r/bin/sigsubfind3r /usr/local/bin/sigsubfind3r

# cp -rf ${script_location}/dotfiles/.config/sigsubfind3r ${HOME}/.config/sigsubfind3r

# }}
# {{ sigurlfind3r

# echo -e " + sigurlfind3r"

# export GOPATH=${tools}/sigurlfind3r
# go install github.com/signedsecurity/sigurlfind3r/cmd/sigurlfind3r@latest &> /dev/null
# ln -sf ${tools}/sigurlfind3r/bin/sigurlfind3r /usr/local/bin/sigurlfind3r

# cp -rf ${script_location}/dotfiles/.config/sigurlfind3r ${HOME}/.config/sigurlfind3r

# }}
# {{ subdomains.sh

# echo -e " + subdomains.sh"

# file="${tools}/subdomains.sh"; [ -e ${file} ] && rm -rf ${file};
# curl -sL https://raw.githubusercontent.com/enenumxela/subdomains.sh/main/subdomains.sh -o ${tools}/subdomains.sh
# chmod u+x ${tools}/subdomains.sh
# ln -sf ${tools}/subdomains.sh /usr/local/bin/subdomains.sh

# }}
# {{ dnsx

# echo -e " + dnsx"

# export GOPATH=${tools}/dnsx
# go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest &> /dev/null
# ln -sf ${tools}/dnsx/bin/dnsx /usr/local/bin/dnsx

# }}
# {{ httpx

# echo -e " + httpx"

# export GOPATH=${tools}/httpx
# go install github.com/projectdiscovery/httpx/cmd/httpx@latest &> /dev/null
# ln -sf ${tools}/httpx/bin/httpx /usr/local/bin/httpx

# }}
# {{ nuclei

# echo -e " + nuclei"

# export GOPATH=${tools}/nuclei
# go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest &> /dev/null
# ln -sf ${tools}/nuclei/bin/nuclei /usr/local/bin/nuclei

# }}
# {{ naabu

# echo -e " + naabu"

# export GOPATH=${tools}/naabu
# go install github.com/projectdiscovery/naabu/cmd/naabu@latest &> /dev/null
# ln -sf ${tools}/naabu/bin/naabu /usr/local/bin/naabu

# }}
# {{ ffuf

# echo -e " + ffuf"

# export GOPATH=${tools}/ffuf
# go install github.com/ffuf/ffuf@latest&> /dev/null
# ln -sf ${tools}/ffuf/bin/ffuf /usr/local/bin/ffuf

# }}
# {{ burp

# echo -e " + burp"

# unzip -P 311138 ${script_location}/files/burp_suite_pro_v2021.8.4.zip -d ${tools}/burp_suite_pro_v2021.8.4 &> /dev/null

# }}
# {{ WORDLISTS

# wordlists="${HOME}/wordlists"; [ ! -d ${wordlists} ] && mkdir -p ${wordlists}

# echo -e " + seclists"

# git_clone "https://github.com/danielmiessler/SecLists.git" "${wordlists}/seclists"

# echo -e " + jhaddix"

# jhaddix="${wordlists}/jhaddix"; [ ! -d ${jhaddix} ] && mkdir -p ${jhaddix}

# curl -sL https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -o ${jhaddix}/content_discovery_all.txt

# }}