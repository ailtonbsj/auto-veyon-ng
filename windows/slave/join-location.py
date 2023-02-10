# Python 3 for Windows 11

from socket import *
from getmac import get_mac_address as gma
import sys

serverName = sys.argv[1]
serverPort = 12000
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect( (serverName, serverPort) )

hostName = gethostname()
macAddr = gma()
clientSocket.send((hostName+","+macAddr).encode('ascii'))
res = clientSocket.recv(1024)
print(res.decode('ascii'))
clientSocket.close()
