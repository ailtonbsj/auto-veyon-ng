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

#sed -i '/Exec=/c\Exec=sudo /usr/bin/veyon-master' /usr/share/applications/veyon-master.desktop
#sed -i '/Terminal=false/c\Terminal=true' /usr/share/applications/veyon-master.desktop

veyon-cli config import confs.json

veyon-cli authkeys create lei
veyon-cli authkeys export lei/public lei.pem
# /etc/veyon/keys/public/lei/key

veyon-cli networkobjects add location "LEI"
echo "You must reboot your system!"

# veyon-cli networkobjects add computer "PC 01" vm22wx.local 08:00:27:97:c5:8b "LEI"
