#!/usr/bin/python3

from socket import *
import os

if(os.geteuid() != 0):
    print("You must be root!")
    exit(1)

serverPort = 12000
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))
serverSocket.listen(1)

print('Discovery of new slaves ready!')

while 1:
    connectionSocket, addr = serverSocket.accept()
    sentence = connectionSocket.recv(1024)
    newMachine = sentence.decode('ascii').split(',')
    print(newMachine)
    os.system("veyon-cli networkobjects add computer \""+ newMachine[0] +"\" "+newMachine[0]+".local "+newMachine[1]+" \"LEI\" 2>/dev/null")
    connectionSocket.send("Ok!".encode('ascii'))
    connectionSocket.close()