REM Join to Veyon Master

net session 1>NUL 2>NUL || (echo Need Admin. & Exit /b 1)

python -c "import socket,sys;sys.stdout.write(socket.gethostbyname('master-win'))" > %temp%\ipadr
set /p masterPC= < %temp%\ipadr

choice /c sn /n /m "Voce deseja se conectar ao servidor mestre padrao (%masterPC%)? [SN]"
if %errorlevel% equ 1 goto joinLocation
if %errorlevel% equ 2 goto finish

:joinLocation
curl "http://%masterPC%/lei.pem" -o "%temp%\lei.pem"
set veyon-cli="C:\Program Files\Veyon\veyon-cli.exe"
%veyon-cli% authkeys import lei/public %temp%\lei.pem
python C:\Windows\join-location.py %masterPC%

:finish
