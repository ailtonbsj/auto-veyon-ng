REM Veyon

net session 1>NUL 2>NUL || (echo Need Admin. & Exit /b 1)

veyon.exe /S /NoMaster /NoStartMenuFolder

set veyon-cli="C:\Program Files\Veyon\veyon-cli.exe"
%veyon-cli% config import confs.json

"C:\Program Files\Python311\python.exe" -m pip install getmac

xcopy "join-location.py" "C:\Windows\" /e
xcopy "join-location.bat" "C:\Windows\" /e

echo "Finished!"
