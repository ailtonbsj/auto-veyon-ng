#!/usr/bin/python3
from socket import *
import netifaces
import sys


serverName = sys.argv[1]+'.local'
serverPort = 12000
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect( (serverName, serverPort) )

hostName = gethostname()
ifaces = netifaces.interfaces()
ifaces.remove('lo')
macAddr = netifaces.ifaddresses(ifaces[0])[netifaces.AF_LINK][0].get('addr')

clientSocket.send((hostName+","+macAddr).encode('ascii'))
res = clientSocket.recv(1024)
print(res.decode('ascii'))
clientSocket.close()