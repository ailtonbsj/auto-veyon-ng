#!/bin/bash

#
# xfce4-terminal -x bash -c 'limpar-todos-arquivos.sh'
#

echo "Executed." > /tmp/wipe.log
cd ~

mkdir /tmp/empty >> /tmp/wipe.log

rsync -r --delete \
--exclude '.*' \
--exclude 'Documentos' \
--exclude 'Downloads' \
--exclude 'Imagens' \
--exclude 'Modelos' \
--exclude 'Músicas' \
--exclude 'Público' \
--exclude 'Vídeos' \
--exclude 'Área\ de\ trabalho' /tmp/empty/ ~/ >> /tmp/wipe.log

rsync -r --delete /tmp/empty/ ~/Documentos/ >> /tmp/wipe.log
rsync -r --delete /tmp/empty/ ~/Downloads/ >> /tmp/wipe.log
rsync -r --delete /tmp/empty/ ~/Imagens/ >> /tmp/wipe.log
rsync -r --delete --exclude 'OpenDocument Spreadsheet.ods' --exclude 'OpenDocument Text.odt' --exclude 'Plain Text.txt' /tmp/empty/ ~/Modelos/ >> /tmp/wipe.log
rsync -r --delete /tmp/empty/ ~/Músicas/ >> /tmp/wipe.log
rsync -r --delete /tmp/empty/ ~/Público/ >> /tmp/wipe.log
rsync -r --delete /tmp/empty/ ~/Vídeos/ >> /tmp/wipe.log
rsync -r --delete /tmp/empty/ ~/Área\ de\ trabalho/ >> /tmp/wipe.log

echo "Finished." >> /tmp/wipe.log
rm -rf up
