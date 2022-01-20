#!/usr/bin/env bash

tools="${HOME}/tools"

if [ ! -d ${tools} ]
then
    mkdir -p ${tools}
fi

CONFIGURATIONS="/tmp/configurations"

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