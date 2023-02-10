REM Veyon Master

net session 1>NUL 2>NUL || (echo Need Admin. & Exit /b 1)

choice /c sn /n /m "Voce deseja renomear o host para master-win ? Isso facilitarah as instalacoes dos slaves. [SN]"
if %errorlevel% equ 1 goto renamePC
if %errorlevel% equ 2 goto finish

:renamePC
wmic computersystem where name="%computername%" call rename name="master-win"

veyon.exe /S

set veyon-cli="C:\Program Files\Veyon\veyon-cli.exe"
%veyon-cli% config import confs.json
%veyon-cli% authkeys create lei
%veyon-cli% authkeys export lei/public C:\xampp\htdocs\lei.pem
%veyon-cli% networkobjects add location "LEI"

xcopy "discovery-slaves.py" "C:\Windows\" /e
xcopy "discovery-slaves.bat" "C:\Windows\" /e

:finish
