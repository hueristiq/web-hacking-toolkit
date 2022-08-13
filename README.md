<h1 align="center">Web Hacking ToolKit</h1>

<p align="center">
	<a href="https://github.com/hueristiq/web-hacking-toolkit/actions">
		<img alt="GitHub Workflow Status" src="https://img.shields.io/github/workflow/status/hueristiq/web-hacking-toolkit/🎉%20CI%20to%20Docker%20Hub">
	</a>
	<a href="https://github.com/hueristiq/web-hacking-toolkit/issues?q=is:issue+is:open">
		<img alt="GitHub Open Issues" src="https://img.shields.io/github/issues-raw/hueristiq/web-hacking-toolkit.svg">
	</a>
	<a href="https://github.com/hueristiq/web-hacking-toolkit/issues?q=is:issue+is:closed">
		<img alt="GitHub Closed Issues" src="https://img.shields.io/github/issues-closed-raw/hueristiq/web-hacking-toolkit.svg">
	</a>
	<a href="https://github.com/hueristiq/web-hacking-toolkit/graphs/contributors">
		<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/hueristiq/web-hacking-toolkit">
	</a>
	<a href="https://github.com/hueristiq/web-hacking-toolkit/blob/master/LICENSE">
		<img alt="GitHub" src="https://img.shields.io/github/license/hueristiq/web-hacking-toolkit">
	</a>
</p>

<p align="center">
	<a href="https://hub.docker.com/r/hueristiq/web-hacking-toolkit/">
		<img alt="Docker Automated build" src="https://img.shields.io/docker/automated/hueristiq/web-hacking-toolkit">
	</a>
	<a href="https://hub.docker.com/r/hueristiq/web-hacking-toolkit/">
		<img alt="Docker Pulls" src="https://img.shields.io/docker/pulls/hueristiq/web-hacking-toolkit">
	</a>
	<a href="https://hub.docker.com/r/hueristiq/web-hacking-toolkit/">
		<img alt="Docker Starts" src="https://img.shields.io/docker/stars/hueristiq/web-hacking-toolkit">
	</a>
	<a href="https://hub.docker.com/r/hueristiq/web-hacking-toolkit/">
		<img alt="Docker Image Size" src="https://img.shields.io/docker/image-size/hueristiq/web-hacking-toolkit/latest">
	</a>
</p>

A web hacking toolkit (docker image).

## Resources

* [Installation](#installation)
	* [Docker](#docker)
	* [Docker Compose](#docker-compose)
	* [Build from Source](#build-from-source)
* [GUI Support](#gui-support)
	* [Using SSH with X11 forwarding](#using-ssh-with-x11-forwarding)
* [Toolkit Setup](#toolkit-setup)
	* [System](#system)
	* [Tools](#tools)
	* [Wordlists](#wordlists)
* [Contribution](#contribution)

## Installation

### Docker

Pull the image from Docker Hub:

```bash
docker pull hueristiq/web-hacking-toolkit
```

Run a container and attach a shell:

```bash
docker run \
	-it \
	--rm \
	--shm-size="2g" \
	--name web-hacking-toolkit \
	--hostname web-hacking-toolkit \
	-p 22:22 \
	-v $(pwd)/data:/root/data \
	hueristiq/web-hacking-toolkit \
	/bin/zsh -l
```
### Docker Compose

Docker-Compose can also be used.

```yaml
version: "3.9"

services:
    web-hacking-toolkit:
        image: hueristiq/web-hacking-toolkit
        container_name: web-hacking-toolkit
        hostname: web-hacking-toolkit
        stdin_open: true
        shm_size: 2gb # increase shared memory size to prevent firefox from crashing
        ports:
            - "22:22" # exposed for GUI support sing SSH with X11 forwarding
        volumes:
            - ./data:/root/data
        restart: unless-stopped
```

Build and run container:

```bash
docker-compose up
```

Attach shell:

```bash
docker-compose exec web-hacking-toolkit /bin/zsh -l
```

### Build from Source

Clone this repository and build the image:

```bash
git clone https://github.com/hueristiq/web-hacking-toolkit.git && \
cd web-hacking-toolkit && \
make build-image
```

Run a container and attach a shell:

```bash
make run
```

## GUI Support

By default, no GUI tools can be run in a Docker container as no X11 server is available. To run them, you must change that. What is required to do so depends on your host machine. If you:

* run on Linux, you probably have X11
* run on Mac OS, you need Xquartz (`brew install Xquartz`)
* run on Windows, you have a problem

### Using SSH with X11 forwarding

Use X11 forwarding through SSH if you want to go this way. Run `start_ssh` inside the container to start the server, make sure you expose port 22 when starting the container: `docker run -p 127.0.0.1:22:22 ...`, then use `ssh -X ...` when connecting (the script prints the password).

## Tookit Setup

* System Setup
	* Terminal
		* Shell ([ZSH](https://www.zsh.org/))
		* Session Manager ([TMUX](https://github.com/tmux/tmux))
	* Browser
		* chrome
		* firefox
	* Remote Connection
		* SSH
* Development
	* Text Editor
		* vim
	* Languages
		* go
		* python3
		* Node, NPM, Yarn
* Tools

	| Name | Description |
	| :--- | :---------- |
	| [amass](https://github.com/OWASP/Amass) | In-depth Attack Surface Mapping and Asset Discovery |
	| [anew](https://github.com/tomnomnom/anew) | A tool for adding new lines to files, skipping duplicates |
	| [arjun](https://github.com/s0md3v/Arjun) | HTTP parameter discovery suite. |
	| [Burp Suite Community](https://portswigger.net/burp) | The BurpSuite Project  community edition. |
	| [cdncheck](https://github.com/enenumxela/cdncheck) | A CLI wrapper for ProjectDiscovery's cdncheck library - "Helper library that checks if a given IP belongs to known CDN ranges (akamai, cloudflare, incapsula and sucuri)". |
	| [cero](https://github.com/glebarez/cero) | Scrape domain names from SSL certificates of arbitrary hosts |
	| [commix](https://github.com/commixproject/commix) | Automated All-in-One OS Command Injection Exploitation Tool. |
	| [crlfuzz](https://github.com/dwisiswant0/crlfuzz) | A fast tool to scan CRLF vulnerability written in Go |
	| [crobat](https://github.com/cgboal/sonarsearch) | A rapid API for the Project Sonar dataset |
	| [curl](https://github.com/curl/curl) | A command line tool and library for transferring data with URL syntax, supporting HTTP, HTTPS, FTP, FTPS, GOPHER, TFTP, SCP, SFTP, SMB, TELNET, DICT, LDAP, LDAPS, MQTT, FILE, IMAP, SMTP, POP3, RTSP and RTMP. libcurl offers a myriad of powerful features |
	| [dalfox](https://github.com/hahwul/dalfox) | waning_crescent_moonfox_face DalFox(Finder Of XSS) / Parameter Analysis and XSS Scanning tool based on golang |
	| dnsutils | - |
	| [dnsvalidator](https://github.com/vortexau/dnsvalidator) | Maintains a list of IPv4 DNS servers by verifying them against baseline servers, and ensuring accurate responses. |
	| [dnsx](https://github.com/projectdiscovery/dnsx) | dnsx is a fast and multi-purpose DNS toolkit allow to run multiple DNS queries of your choice with a list of user-supplied resolvers. |
	| [dotdotpwn](https://github.com/wireghoul/dotdotpwn) | DotDotPwn - The Directory Traversal Fuzzer |
	| [duplicut](https://github.com/nil0x42/duplicut) | Quickly dedupe massive wordlists, without changing the order |
	| [ffuf](https://github.com/ffuf/ffuf) | Fast web fuzzer written in Go |
	| [findomain](https://github.com/Edu4rdSHL/findomain) | The fastest 
	| [gin](https://github.com/sbp/gin) | Git index file parser, using python3 |
	| [gowitness](https://github.com/sensepost/gowitness) | gowitness - a golang, web screenshot utility using Chrome Headless |
	| [gotator](https://github.com/Josue87/gotator) | Gotator is a tool to generate DNS wordlists through permutations. |
	| [grep](https://www.gnu.org/software/grep/) | Grep searches one or more input files for lines containing a match to a specified pattern. |
	| [hakrevdns](https://github.com/hakluke/hakrevdns) | Small, fast, simple tool for performing reverse DNS lookups en masse. |
	| [hqcrawl3r](https://github.com/hueristiq/hqcrawl3r) | A fast web crawler. |
	| [hqnotifi3r](https://github.com/hueristiq/hqnotifi3r) | A helper utility to send messages from CLI to Slack.. |
	| [hqsubfind3r](https://github.com/hueristiq/hqsubfind3r) | A subdomain discovery tool - it gathers a list of subdomains passively using various online sources. |
	| [hqs3scann3r](https://github.com/hueristiq/hqs3scann3r) | A tool to scan AWS S3 bucket permissions. |
	| [hqurl](https://github.com/hueristiq/hqurl) | A go(golang) utility for URLs parsing & pull out bits of the URLS. |
	| [hqurlfind3r](https://github.com/hueristiq/hqurlfind3r) | A passive reconnaissance tool for known URLs discovery - it gathers a list of URLs passively using various online sources. |
	| [hqurlscann3r](https://github.com/hueristiq/hqurlscann3r) | A web application attack surface mapping tool. It takes in a list of urls then performs numerous probes |
	| [httpx](https://github.com/projectdiscovery/httpx) | httpx is a fast and multi-purpose HTTP toolkit allow to run multiple probers using retryablehttp library, it is designed to maintain the result reliability with increased threads. |
	| [interlace](https://github.com/codingo/Interlace) | Easily turn single threaded command line applications into a fast, multi-threaded application with CIDR and glob support. |
	| [jq](https://github.com/stedolan/jq) | Command-line JSON processor |
	| [masscan](https://github.com/robertdavidgraham/masscan) | TCP port scanner, spews SYN packets asynchronously, scanning entire Internet in under 5 minutes. |
	| [massdns](https://github.com/blechschmidt/massdns) | A high-performance DNS stub resolver. |
	| [naabu](https://github.com/projectdiscovery/naabu) | A fast port scanner written in go with focus on reliability and simplicity. Designed to be used in combination with other tools for attack surface discovery in bug bounties and pentests |
	| net-tools | - |
	| [nmap](https://github.com/nmap/nmap) | Nmap - the Network Mapper. Github mirror of official SVN repository. |
	| [nmap-utils](https://github.com/enenumxela/nmap-utils) | Scripts to process nmap results. |
	| [nuclei](https://github.com/projectdiscovery/nuclei) | Nuclei is a fast tool for configurable targeted scanning based on templates offering massive extensibility and ease of use. |
	| [ping](https://github.com/iputils/iputils) | Tools to test the reachability of network hosts. |
	| [ps.sh](https://github.com/enenumxela/ps.sh) | A wrapper around tools used for port scanning(nmap, naabu & masscan), the goal being reducing scan time, increasing scan efficiency and automating the workflow. |
	| [puredns](https://github.com/d3mondev/puredns) | Puredns is a fast domain resolver and subdomain bruteforcing tool that can accurately filter out wildcard subdomains and DNS poisoned entries.  |
	| [sqlitebrowser](https://sqlitebrowser.org/) | A high quality, visual, open source tool to create, design, and edit database files compatible with SQLite. |
	| [sqlmap](https://github.com/sqlmapproject/sqlmap) | Automatic SQL injection and database takeover tool |
	| [subdomains.sh](https://github.com/hueristiq/subdomains.sh) | A wrapper around tools used for subdomain enumeration, to automate the workflow, on a given domain, written in bash. |
	| [subfinder](https://github.com/projectdiscovery/subfinder) | Subfinder is a subdomain discovery tool that discovers valid subdomains for websites. Designed as a passive framework to be useful for bug bounties and safe for penetration testing. |
	| [waf00f](https://github.com/EnableSecurity/wafw00f) | The Web Application Firewall Fingerprinting Tool. |
	| [wappalyzer](https://github.com/aliasio/wappalyzer) | Wappalyzer identifies technologies on websites, such as CMS, web frameworks, ecommerce platforms, JavaScript libraries, analytics tools and more. |
	| whois | whois - client for the whois directory service |
	| [whatweb](https://github.com/urbanadventurer/WhatWeb) | Next generation web scanner. |
	| [whois](https://github.com/rfc1036/whois) | client for the whois directory service |
	| [wpscan](https://github.com/wpscanteam/wpscan) | WordPress Security Scanner |
	| [wuzz](https://github.com/asciimoo/wuzz) | Interactive cli tool for HTTP inspection |
	| [OWASP Zed Attack Proxy (ZAP)](https://www.zaproxy.org/) | an open-source web application security scanner. |

* Wordlists

	| Wordlist | Description |
	| :------- | :---------- |
	| [resolvers](https://github.com/hueristiq/resolvers.git) | An exhaustive list of DNS resolvers. |
	| [wordlists](https://github.com/hueristiq/wordlists.git) | A collection of wordlists generated by combining various common/popular wordlists. |

## Contribution

[Issues](https://github.com/hueristiq/web-hacking-toolkit/issues) and [Pull Requests](https://github.com/hueristiq/web-hacking-toolkit/pulls) are welcome!