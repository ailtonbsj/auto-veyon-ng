#!/bin/bash

#
# https://docs.veyon.io/en/latest/admin/cli.html
#

if [ "$(id -u)" != "0" ]; then
    echo "You must be root!"
    exit 1
fi

wget -q --no-check-certificate --show-progress -O /tmp/veyon.deb "https://github.com/veyon/veyon/releases/download/v4.8.3/veyon_4.8.3.0-ubuntu.mantic_amd64.deb"

apt update
apt install /tmp/veyon.deb -y

echo "Waiting for master beam..."
masterPC=$(nc -w1 -lup 12001).local
zenity --question --width=300 --title="Alterar mestre" --text="Você deseja se conectar ao servidor mestre $masterPC ?"
if [ "$?" == "1" ]; then
    echo "Exiting..."
    exit
fi

veyon-cli config import confs.json
wget http://$masterPC:8000/lei.pem -O lei.pem
veyon-cli authkeys import lei/public lei.pem

sleep 2
systemctl restart veyon.service
python3 join-location.py $masterPC

rm /usr/share/applications/veyon-master.desktop
