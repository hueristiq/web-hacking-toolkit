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