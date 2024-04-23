# Auto Veyon NG

Automation for installation of Veyon Linux Ubuntu 24.04 or Windows 11.


## How to use

On *master computer* run `sudo ./main.sh` then reboot.

After that run the command `sudo ./discovery-slaves.py`.

Left this command running until you provissionate all slaves computers of your lab.

On each *slaves computers* run `sudo ./main.sh` from slave folder.

The command will wait a beam from master computer e than will automatic join to veyon.
