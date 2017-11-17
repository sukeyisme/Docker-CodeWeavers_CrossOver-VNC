# !/bin/bash

${INSTALLDIR}/bin/cxbottle --create --bottle "${BOTTLE}" --description "IDM容器" --template "winxp"
sed -i -e 's/;;"AllowUntrusted" = ""/"AllowUntrusted" = "1"/' ${HOME}/.cxoffice/${BOTTLE}/cxbottle.conf

# 安装ie8浏览器
echo '接下来，需要在CrossOver中安装Internet Explorer 8 (网络与通信 > 浏览器 >Internet Explorer 8)'
${INSTALLDIR}/bin/crossover

[[ -d /mnt/drive_d ]] && ln -sf /mnt/drive_d "${HOME}/.cxoffice/${BOTTLE}/dosdevices/d:"

${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --wait-children --wl-app 'reboot.exe'