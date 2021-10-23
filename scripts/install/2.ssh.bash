#!/bin/bash

set -e

echo -e " + ssh"

if [ ! -x "$(command -v ssh)" ]
then
	apt -y -qq install openssh-server &> /dev/null
fi

sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd