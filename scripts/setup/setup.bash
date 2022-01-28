#!/usr/bin/env bash

tools="${HOME}/tools"

if [ ! -d ${tools} ]
then
    mkdir -p ${tools}
fi

CONFIGURATIONS="/tmp/configurations"

# {{ firefox (Browser)

echo -e " + firefox"

apt-get install -y -qq firefox-esr libcanberra-gtk3-module

mv -f ${CONFIGURATIONS}/.mozilla ${HOME}/.mozilla

# }} firefox (Browser)
# {{ burpsuite

echo -e " + burpsuite"

apt-get install -y -qq burpsuite

# }} burpsuite
# {{ whois

echo -e " + whois"

apt-get install -y -qq whois

# }} whois
# {{ httpx

echo -e " + httpx"

go install github.com/projectdiscovery/httpx/cmd/httpx@latest

# }}













# {{ Discovery

echo -e " + Discovery"

# {{ Domain

echo -e " +     Domain"

# {{ amass

echo -e " +         amass"

go install github.com/OWASP/Amass/v3/...@latest

# }} amass
# {{ subfinder

echo -e " +         subfinder"

go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# }} subfinder
# {{ findomain

echo -e " +         findomain"

file="/usr/local/bin/findomain"

curl -sL https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -o ${file}

if [ -f ${file} ]
then
	chmod u+x ${file}
fi

# }} findomain
# {{ sigsubfind3r

echo -e " +         sigsubfind3r"

go install github.com/signedsecurity/sigsubfind3r/cmd/sigsubfind3r@latest

# }} sigsubfind3r
# {{ subdomains.sh

echo -e " +         subdomains.sh"

file="/usr/local/bin/subdomains.sh"

curl -sL https://raw.githubusercontent.com/enenumxela/subdomains.sh/main/subdomains.sh -o ${file}

if [ -f ${file} ]
then
	chmod u+x ${file}
fi

# }} subdomains.sh

# }} Domain
# {{ DNS

echo -e " +     DNS"

# {{ dnsx

echo -e " +         dnsx"

go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest

# }} dnsx
# {{ hakrevdns

echo -e " +         hakrevdns"

go install github.com/hakluke/hakrevdns@latest

# }} hakrevdns

# }} DNS
# {{ PORT

echo -e " +     PORT"

# {{ nmap

echo -e " +         nmap"

apt-get install -y -qq nmap

# }} nmap
# {{ naabu

echo -e " +         naabu"

apt-get install -y -qq libpcap-dev
go install github.com/projectdiscovery/naabu/cmd/naabu@latest

# }} naabu
# {{ masscan

echo -e " +         masscan"

apt-get install -y -qq masscan

# }} masscan
# {{ ps.sh

echo -e " +         ps.sh"

apt-get install -y -qq libxml2-utils

file="/usr/local/bin/ps.sh"

curl -sL https://raw.githubusercontent.com/enenumxela/ps.sh/main/ps.sh -o ${file}

if [ -f ${file} ]
then
	chmod u+x ${file}
fi

# }} ps.sh

# }} PORT
# {{ Technologies

echo -e " +     Technologies"

# {{ whatweb

echo -e " +         whatweb"

apt-get install -y -qq whatweb

# }} whatweb
# {{ wappalyzer

echo -e " +         wappalyzer"

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

echo -e " +     URL"

# {{ sigurlfind3r

echo -e " +         sigurlfind3r"

go install github.com/signedsecurity/sigurlfind3r/cmd/sigurlfind3r@latest

# }} sigurlfind3r

# }} URL
# }} Parameters

echo -e " +     Parameters"

# {{ arjun

echo -e " +         arjun"

apt-get install -y -qq arjun

# }} arjun

# }} Parameters
# }} Fuzz

echo -e " +     Fuzz"

# {{ ffuf

echo -e " +         ffuf"

go install github.com/ffuf/ffuf@latest

# }} ffuf

# }} Fuzz

# }} Discovery
# {{ Scanner

echo -e " + Scanner"

echo -e " +    Army-Knife"

# {{ nuclei

echo -e " +         nuclei"

go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

# }}
# {{ sigurlscann3r

echo -e " +         sigurlscann3r"

go install github.com/signedsecurity/sigurlscann3r/cmd/sigurlscann3r@latest

# }}

echo -e " +     Command Injection"

# {{ commix

echo -e " +         commix"

apt-get install -y -qq commix

# }} commix

echo -e " +     SQL Injection"

# {{ sqlmap

echo -e " +         sqlmap"

apt-get install -y -qq sqlmap

# }} sqlmap

echo -e " +     Cross Site Scripting"

# {{ dalfox

echo -e " +         dalfox"

go install github.com/hahwul/dalfox/v2@latest

# }} dalfox

echo -e " +     CRLF Injection"

# {{ crlfuzz

echo -e " +         crlfuzz"

go install github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest

# }} crlfuzz

echo -e " +     Directory Traversal"

# {{ dotdotpwn

echo -e " +         dotdotpwn"

apt-get install -y -qq dotdotpwn

# }} dotdotpwn

# }} Scanner
# {{ Utilities 

echo -e " + Utilities"

# {{ Screenshot

echo -e " +     Screenshot"

# {{ gowitness

echo -e " +         gowitness"

go install github.com/sensepost/gowitness@latest

# }} gowitness

# }} Screenshot
# {{ JSON 

echo -e " +     JSON"

# {{ jq

echo -e " +         jq"

apt-get install -y -qq jq

# }} jq

# }} JSON
# {{ urlx

echo -e " +         urlx"

go install github.com/enenumxela/urlx/cmd/urlx@latest

# }} urlx
# {{ anew

echo -e " +         anew"

go install github.com/tomnomnom/anew@latest

# }} anew
# {{ wuzz

echo -e " +         wuzz"

go install github.com/asciimoo/wuzz@latest

# }} wuzz

# }} Utilities
# {{ Wordlists

echo -e " + Wordlists"

wordlists="${HOME}/wordlists"

if [ ! -d ${wordlists} ]
then
	mkdir -p ${wordlists}
fi

# {{ seclists

echo -e " +     seclists"

git clone https://github.com/danielmiessler/SecLists.git ${wordlists}/seclists

# }} seclists
# {{ jhaddix/content_discovery_all.txt

echo -e " +     jhaddix/content_discovery_all.txt"

jhaddix="${wordlists}/jhaddix"; [ ! -d ${jhaddix} ] && mkdir -p ${jhaddix}

curl -sL https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -o ${jhaddix}/content_discovery_all.txt

# }} jhaddix/content_discovery_all.txt

# }} Wordlists