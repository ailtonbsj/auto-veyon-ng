#!/bin/bash

#
# https://docs.veyon.io/en/latest/admin/cli.html
#

if [ "$(id -u)" != "0" ]; then
    echo "You must be root!"
    exit 1
fi

zenity --question --width=320 --title "Renomear Computador" \
--text="Você deseja renomear o host para master-lei ? Isso facilitará as instalações dos slaves."
if [ "$?" == "0" ]; then
    pcName="master-lei"
    echo "$pcName" > /etc/hostname
    sed -i "/127.0.1.1/c\127.0.1.1\t$pcName" /etc/hosts
fi

echo "Caso demorar aqui, pressione ENTER!"

add-apt-repository ppa:veyon/stable -y
apt install veyon -y
apt install apache2 -y

sed -i '/Exec=/c\Exec=sudo /usr/bin/veyon-master' /usr/share/applications/veyon-master.desktop
sed -i '/Terminal=false/c\Terminal=true' /usr/share/applications/veyon-master.desktop

veyon-cli config import confs.json
veyon-cli authkeys create lei
veyon-cli authkeys export lei/public /var/www/html/lei.pem

veyon-cli networkobjects add location "LEI"
reboot

# veyon-cli networkobjects add computer "PC 01" vm22wx.local 08:00:27:97:c5:8b "LEI"
