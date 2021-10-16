# Web Hacking ToolKit

## Tools

| Interface | Name | Descripton |
| :-------: | :--- | :--------- |
| GUI | [BurpSuitePro](https://portswigger.net/burp) | the BurpSuite Project |
| CLI | [wuzz](https://github.com/asciimoo/wuzz) | Interactive cli tool for HTTP inspection |
| CLI | [httpx](https://github.com/projectdiscovery/httpx) | httpx is a fast and multi-purpose HTTP toolkit allow to run multiple probers using retryablehttp library, it is designed to maintain the result reliability with increased threads. |
| CLI | [ffuf](https://github.com/ffuf/ffuf) | Fast web fuzzer written in Go |
| CLI | [anew](https://github.com/tomnomnom/anew) | A tool for adding new lines to files, skipping duplicates |
| CLI | [curl](https://github.com/curl/curl) | A command line tool and library for transferring data with URL syntax, supporting HTTP, HTTPS, FTP, FTPS, GOPHER, TFTP, SCP, SFTP, SMB, TELNET, DICT, LDAP, LDAPS, MQTT, FILE, IMAP, SMTP, POP3, RTSP and RTMP. libcurl offers a myriad of powerful features |
| CLI | [dnsx](https://github.com/projectdiscovery/dnsx) | dnsx is a fast and multi-purpose DNS toolkit allow to run multiple DNS queries of your choice with a list of user-supplied resolvers. |
| CLI | [Amass](https://github.com/OWASP/Amass) | In-depth Attack Surface Mapping and Asset Discovery |
| CLI | [findomain](https://github.com/Edu4rdSHL/findomain) | The fastest and cross-platform subdomain enumerator, do not waste your time. |
| CLI | [subfinder](https://github.com/projectdiscovery/subfinder) | Subfinder is a subdomain discovery tool that discovers valid subdomains for websites. Designed as a passive framework to be useful for bug bounties and safe for penetration testing. |
| CLI | [naabu](https://github.com/projectdiscovery/naabu) | A fast port scanner written in go with focus on reliability and simplicity. Designed to be used in combination with other tools for attack surface discovery in bug bounties and pentests |
| CLI | [nmap](https://github.com/nmap/nmap) | Nmap - the Network Mapper. Github mirror of official SVN repository. |

## GUI and Containers

By default, no GUI tools can be run in a Docker container as no X11 server is available. To run them, you must change that. What is required to do so depends on your host machine. If you:

* run on Linux, you probably have X11
* run on Mac OS, you need Xquartz (`brew install Xquartz`)
* run on Windows, you have a problem

Use X11 forwarding through SSH if you want to go this way. Run `start_ssh.bash` inside the container to start the server, make sure you expose port 22 when starting the container: `docker run -p 127.0.0.1:22:22 ...`, then use `ssh -X ...` when connecting (the script prints the password).

To not depend on X11, the image also comes with a TigerVNC server and noVNC client. You can use it to open an HTML5 VNC session with your browser to connect to the containers Xfce desktop. To to that, run `start_vnc.bash` inside the container to start server and client, make sure you expose port 6901 when starting the container `docker run -p 127.0.0.1:6901:6901 ...` and go to `localhost:6901/?password=<the_password>` (the script prints the password).

### Using SSH with X11 forwarding

### Using Browser and VNC