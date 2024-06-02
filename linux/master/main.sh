#!/bin/bash

#
# https://docs.veyon.io/en/latest/admin/cli.html
#

if [ "$(id -u)" != "0" ]; then
    echo "You must be root!"
    exit 1
fi

apt update

debpkg=/usr/wx-center/modules/Veyon/veyon.deb
if [ ! -f $debpkg ]; then
    wget -q --no-check-certificate --show-progress -O /tmp/veyon.deb "https://github.com/veyon/veyon/releases/download/v4.8.3/veyon_4.8.3.0-ubuntu.mantic_amd64.deb"
    apt install /tmp/veyon.deb -y
else
    apt install $debpkg -y
fi

veyon-cli config import confs.json

veyon-cli authkeys create lei
chown :escola /etc/veyon/keys/private/lei/key
chown :escola /etc/veyon/keys/public/lei/key

veyon-cli authkeys export lei/public lei.pem

veyon-cli networkobjects add location "LEI"
echo "You must reboot your system!"
