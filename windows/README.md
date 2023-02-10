# auto-veyon

Automation for installation of Veyon in Windows 11.

## Requirements

- Windows 11
- Python 3
- XAMPP

## How to install master

- Install Windows 11 on master PC.
- Install Python 3 and XAMPP.
- Start apache on XAMPP as a service.
- Download Veyon installer and save as `veyon.exe` on master folder
- Run `install-master.bat` on `cmd.exe` as Administrator
- Run `python discovery-slaves.py` on `cmd.exe` as Administrator

## How to install slave

- Install Windows 11 on slaves PCs.
- Download Veyon installer and save as `veyon.exe` on master folder
- Run `install.bat`  on `cmd.exe` as Administrator.
