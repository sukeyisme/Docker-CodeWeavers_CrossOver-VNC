#!/bin/bash

${INSTALLDIR}/bin/cxbottle --create --bottle "${BOTTLE}" --description "百度网盘wine容器" --template "winxp"

sed -i -e 's/;;"AllowUntrusted" = ""/"AllowUntrusted" = "1"/' ${HOME}/.cxoffice/${BOTTLE}/cxbottle.conf

Starting: '/opt/cxoffice/bin/cxassoc' --bottle ${BOTTLE} '--sync'
Starting: '/opt/cxoffice/bin/wine' '--scope' 'private' '--no-convert' '--wl-app' 'assocscan.exe' '--scan' '--icon-dir' '/home/crossover/.cxoffice/BaiduNetDisk/windata/Associations'
Starting '/opt/cxoffice/bin/wineloader' 'winewrapper.exe' '--no-convert' '--run' '--'
Starting '/opt/cxoffice/bin/wineloader' 'winewrapper.exe' '--wait-children' '--no-convert' '--run' '--'

for font in /tmp/fonts/*; do
  ${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" --untrusted --wait-children --no-convert -- 'cxinstallfonts.exe' "${font}"
done

env LC_ALL="en_US.UTF-8" ${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" --untrusted --wait-children --no-convert --new-console -- "/tmp/installers/exe/Firefox Setup 20.0_zh-CN.exe" "-ms" && rm -f "/tmp/Firefox Setup 20.0.exe"

  ${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --untrusted --wait-children --no-convert --new-console --dll 'msxml3=n' -- 'msiexec.exe' '/i' '/tmp/msxml3.msi'
  ${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --untrusted --wait-children --no-convert --new-console --dll 'iexplore.exe=n' '--' '/tmp/IE8-WindowsXP-x86-ENU.exe'
  # 开始菜单快捷方式
  ${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --wait-children --wl-app cxmklnk.exe -- --lnkfile 'C:\users\crossover\Start Menu//Internet Explorer.lnk' --target 'C:\Program Files/Internet Explorer/iexplore.exe'
  # ${INSTALLDIR}/bin/wineshelllink --utf8 --root 'C:\users\crossover\Start Menu' --link 'C:\users\crossover\Start Menu\Internet Explorer.lnk' '--path' 'C:\Program Files\Internet Explorer\iexplore.exe' '--menu' '--icon' 'FB4C_iexplore.0'
  # ${INSTALLDIR}/bin/cxmenu '--utf8' '--create' 'StartMenu.C^3A_users_crossover_Start+Menu/Internet Explorer.lnk' '--type' 'windows' '--install' '--icon' 'FB4C_iexplore.0' '--shortcut' 'iexplore'
  # ${INSTALLDIR}/bin/cxmenu --bottle ${BOTTLE} '--sync' '--mode' 'install'
  ${INSTALLDIR}/bin/wine '--scope' 'private' '--no-convert' '--wl-app' 'winemenubuilder.exe' '--cx-dump-menus' '--cx-all-menus'
  ${INSTALLDIR}/bin/cxassoc --bottle ${BOTTLE} --sync --sync-mode --mode 'mime;default=\.asx:\.wma:\.wmx:\.asf:\.wm:\.wmv:\.wax;alternative=\.avi:\.mov:\.qt'
  ${INSTALLDIR}/bin/cxnsplugin --bottle ${BOTTLE} --sync --mode 'ignore'
  ${INSTALLDIR}/bin/wine --scope 'private' --no-convert --wl-app 'assocscan.exe' --scan --icon-dir '/home/crossover/.cxoffice/BaiduNetDisk/windata/Associations'
  ${INSTALLDIR}/bin/wine '--scope' 'private' '--wl-app' 'pluginserver.exe' '--scandlls'

#  wget https://raw.githubusercontent.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/master/BaiduNetdisk/BaiduNetdisk.tar.xz -O /tmp/BaiduNetdisk.tar.xz && \
tar -Jxf /tmp/installers/BaiduNetdisk.tar.xz -C ${HOME}/.cxoffice/${BOTTLE}/drive_c/Program\ Files/
sudo mv /tmp/installers/dll/riched20.dll ${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/
sudo mv /tmp/installers/dll/riched32.dll ${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/
sudo mkdir -p /mnt/drive_d/BaiduNetdiskDownload && sudo chown ${USER}:root -R /mnt/drive_d && sudo chmod 777 -R /mnt/drive_d/BaiduNetdiskDownload
ln -sf /mnt/drive_d "${HOME}/.cxoffice/${BOTTLE}/dosdevices/d:"
${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --wait-children --wl-app 'reboot.exe'
# env LC_ALL="en_US.UTF-8" ${INSTALLDIR}/bin/cxreboot --bottle ${BOTTLE}
