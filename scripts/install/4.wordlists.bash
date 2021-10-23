#!/usr/bin/env bash

set -e

git_clone() {
	if [ -d ${2} ]
	then
		git -C ${2} pull &> /dev/null
	else
		git clone ${1} ${2} &> /dev/null
	fi
}

wordlists="${HOME}/wordlists"; [ ! -d ${wordlists} ] && mkdir -p ${wordlists}

echo -e " + jhaddix"

jhaddix="${wordlists}/jhaddix"; [ ! -d ${jhaddix} ] && mkdir -p ${jhaddix}

curl -sL https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -o ${jhaddix}/content_discovery_all.txt

echo -e " + seclists"

git_clone "https://github.com/danielmiessler/SecLists.git" "${wordlists}/seclists"
