# !/bin/bash

${INSTALLDIR}/bin/cxbottle --create --bottle "${BOTTLE}" --description "百度网盘wine容器" --template "winxp"
sed -i -e 's/;;"AllowUntrusted" = ""/"AllowUntrusted" = "1"/' ${HOME}/.cxoffice/${BOTTLE}/cxbottle.conf

for font in /tmp/fonts/*; do
	${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" --untrusted --wait-children --no-convert -- 'cxinstallfonts.exe' "${font}"
done

sudo mkdir -p /mnt/drive_d/
ln -sf /mnt/drive_d "${HOME}/.cxoffice/${BOTTLE}/dosdevices/d:"

# 安装ie8浏览器
echo '接下来，需要在CrossOver中安装Internet Explorer 8 (网络与通信 > 浏览器 >Internet Explorer 8)'
${INSTALLDIR}/bin/crossover

# wget https://raw.githubusercontent.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/master/BaiduNetdisk/BaiduNetdisk.tar.xz -O /tmp/BaiduNetdisk.tar.xz && \
tar -Jxf /tmp/installers/BaiduNetdisk.tar.xz -C ${HOME}/.cxoffice/${BOTTLE}/drive_c/Program\ Files/
sudo mv /tmp/installers/dll/riched20.dll ${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/
sudo mv /tmp/installers/dll/riched32.dll ${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/

${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --wait-children --wl-app 'reboot.exe'