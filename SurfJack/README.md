This is a demonstration tool for the Surf Jack attack.
It is able to hijack the cookie for various sites
(some of which make use of HTTPS) and allows the tester to login as the victim.

By: Sandro Gauci <sandro@enablesecurity.com>

Requirements:
Scapy - http://www.secdev.org/projects/scapy/
Scapy's requirements
Python 2.4+

Features:
	* Does Wireless injection when the nic is in monitor mode
	* Supports Ethernet
	* Support for WEP (when the nic is in monitor mode)

Known issues:
	* Sometimes the victim is not redirected correctly (particularly seen when targeting Gmail)
	* Cannot stop the tool via a simple Control^C. This is a problem with the proxy

Installation:
	1. Get scapy from http://hg.secdev.org/scapy/raw-file/tip/scapy.py
		For more on installation of scapy:
		http://www.secdev.org/projects/scapy/portability.html
	2. Extract Surf Jack files into the same directory as scapy.py

Running:
$ ./surfjack.py --help
Usage: just run surfjack.py. use --help to print out the help

Options:
  --version         show program's version number and exit
  -h, --help        show this help message and exit
  -i INTERFACE      specify an interface
  -v                increase verbosity
  -q                quiet mode
  -j INJIFACE       interface to use to inject packets with
  -W WEPKEY         WEP key
  -c CONFIG         Specify a custom configuration file
  --dontignoreself  Disable ignoring of own traffic
  
$ ./surfjack.py -i wlan0 -v
