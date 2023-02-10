#!/bin/bash

#
# https://docs.veyon.io/en/latest/admin/cli.html
#

if [ "$(id -u)" != "0" ]; then
    echo "You must be root!"
    exit 1
fi

masterPC="master-lei"
zenity --question --width=300 --title="Alterar mestre" --text="Você deseja se conectar ao servidor mestre padrão ($masterPC) ?"
if [ "$?" == "1" ]; then
    masterPC=$(zenity --entry --width=300 --title="hostname do master" --text="Digite o hostname do mestre sem .local")
    echo "Usando servidor $masterPC.local"
fi

add-apt-repository ppa:veyon/stable -y
apt install veyon -y

veyon-cli config import confs.json
wget http://$masterPC.local/lei.pem -O lei.pem
veyon-cli authkeys import lei/public lei.pem

sleep 2
systemctl restart veyon.service
python3 join-location.py $masterPC

rm /usr/share/applications/veyon-configurator.desktop
rm /usr/share/applications/veyon-master.desktop
