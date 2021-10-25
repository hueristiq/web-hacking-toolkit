#!/usr/bin/env bash

tools="${HOME}/tools"

mkdir -p ${tools}

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

file="${tools}/findomain"; [ -e ${file} ] && rm -rf ${file};
curl -sL https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -o ${tools}/findomain
chmod u+x ${tools}/findomain
ln -sf ${tools}/findomain /usr/local/bin/findomain

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

file="${tools}/subdomains.sh"; [ -e ${file} ] && rm -rf ${file};
curl -sL https://raw.githubusercontent.com/enenumxela/subdomains.sh/main/subdomains.sh -o ${tools}/subdomains.sh
chmod u+x ${tools}/subdomains.sh
ln -sf ${tools}/subdomains.sh /usr/local/bin/subdomains.sh

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
# {{ ffuf

echo -e " + ffuf"

go install github.com/ffuf/ffuf@latest

# }}
# {{ ffuf

echo -e " + html-tool"

go install github.com/tomnomnom/hacks/html-tool@latest

# }}
# {{ wappalyzer

echo -e " + wappalyzer"

git clone https://github.com/AliasIO/wappalyzer.git ${tools}/wappalyzer
cd ${tools}/wappalyzer
yarn install
yarn run link
cd -

# }}