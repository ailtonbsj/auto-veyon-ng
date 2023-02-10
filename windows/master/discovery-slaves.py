# Python 3 for Windows 11

from socket import *
import os, subprocess, ctypes

if ctypes.windll.shell32.IsUserAnAdmin() == 0:
    print('Need admin.')
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
    subprocess.call('"C:/Program Files/Veyon/veyon-cli.exe" networkobjects add computer "'+ newMachine[0] +'" "'+ newMachine[0] +'.local" "'+ newMachine[1] +'" "LEI"')
    connectionSocket.send("Ok!".encode('ascii'))
    connectionSocket.close()
