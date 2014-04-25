#!/usr/bin/python
#
# Basic UDP protocol flooder
# ToDo: Spoof IP random ports

import socket
import sys

options = '''
Usage: ./udp_flood.py [options]
options: -t --target  <host>
         -p --port    <port>
         -h --help    <help>

Example: ./udp_flood.py -t 192.168.1.0

'''
    

def banner():
    print(options)
    sys.exit(1)

for arg in sys.argv:
    if arg.lower() == 't' or arg.lower() == '--target':
        host = sys.argv[int(sys.argv[1:].index(arg))+2]
    elif arg.lower() == 'p' or arg.lower() == '--port':
        port = sys.argv[int(sys.argv[1:].index(arg))+2]
    elif arg.lower() == 'h' or arg.lower() == '--help':
        print(banner())
    elif len(sys.argv) < 1:
        print(banner())

# Create udp connection

HOST = ''  # The remote host
PORT = ''
s = None
for res in socket.getaddrinfo(HOST, PORT, socket.AF_UNSPEC, socket.SOCK_STREAM):
    af, socktype, proto, canonname, sa = res
    try:
        S = socket.socket(af, socktype, proto)
    except socket.error as msg:
        s = None
        continue
    try:
        s.connect(sa)
    except socket.error as msg:
        s.close()
        s = None
        continue
    break
if s is None:
    print('could not open socket')
    sys.exit(1)
s.send(b'Hello, world')
data = s.recv(1024)
s.close()
print('Recieved', repr(data))


    
