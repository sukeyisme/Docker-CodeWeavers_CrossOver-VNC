#!/bin/bash

${INSTALLDIR}/bin/cxbottle --create --bottle "${BOTTLE}" --description "百度网盘wine容器" --template "winxp"

sed -i -e 's/;;"AllowUntrusted" = ""/"AllowUntrusted" = "1"/' ${HOME}/.cxoffice/${BOTTLE}/cxbottle.conf

for font in /tmp/fonts/*; do
  ${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" --untrusted --wait-children --no-convert -- 'cxinstallfonts.exe' "${font}"
done

env LC_ALL="en_US.UTF-8" ${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" --untrusted --wait-children --no-convert --new-console -- "/tmp/installers/exe/Firefox Setup 20.0_zh-CN.exe" "-ms" && rm -f "/tmp/Firefox Setup 20.0.exe"

#  wget https://raw.githubusercontent.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/master/BaiduNetdisk/BaiduNetdisk.tar.xz -O /tmp/BaiduNetdisk.tar.xz && \
tar -Jxf /tmp/installers/BaiduNetdisk.tar.xz -C ${HOME}/.cxoffice/${BOTTLE}/drive_c/Program\ Files/
sudo mv /tmp/installers/dll/riched20.dll ${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/
sudo mv /tmp/installers/dll/riched32.dll ${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/
sudo mkdir -p /mnt/drive_d/BaiduNetdiskDownload && sudo chown ${USER}:root -R /mnt/drive_d && sudo chmod 777 -R /mnt/drive_d/BaiduNetdiskDownload
ln -sf /mnt/drive_d "${HOME}/.cxoffice/${BOTTLE}/dosdevices/d:"
env LC_ALL="en_US.UTF-8" ${INSTALLDIR}/bin/cxreboot --bottle ${BOTTLE}
