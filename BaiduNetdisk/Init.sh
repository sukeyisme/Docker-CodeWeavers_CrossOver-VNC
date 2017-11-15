# !/bin/bash

${INSTALLDIR}/bin/cxbottle --create --bottle "${BOTTLE}" --description "百度网盘wine容器" --template "winxp"

sed -i -e 's/;;"AllowUntrusted" = ""/"AllowUntrusted" = "1"/' ${HOME}/.cxoffice/${BOTTLE}/cxbottle.conf

for font in /tmp/fonts/*; do
  ${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" --untrusted --wait-children --no-convert -- 'cxinstallfonts.exe' "${font}"
done


sudo mkdir -p /mnt/drive_d/BaiduNetdiskDownload && sudo chown ${UID}:${GID} -R /mnt/drive_d
ln -sf /mnt/drive_d "${HOME}/.cxoffice/${BOTTLE}/dosdevices/d:"
env LC_ALL="en_US.UTF-8" ${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --wait-children --wl-app 'reboot.exe'
env LC_ALL="en_US.UTF-8" ${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" --untrusted --wait-children --no-convert --new-console -- "/tmp/installers/exe/Firefox Setup 20.0_zh-CN.exe" "-ms" && rm -f "/tmp/Firefox Setup 20.0.exe"

# 安装ie8浏览器
# prepare
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "iexplore.exe" /t REG_SZ /d "native, builtin" /f
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "itircl" /t REG_SZ /d "native, builtin" /f
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "itss" /t REG_SZ /d "native, builtin" /f
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "jscript" /t REG_SZ /d "native, builtin" /f
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "mlang" /t REG_SZ /d "native, builtin" /f
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "mshtml" /t REG_SZ /d "native, builtin" /f
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "msimtf" /t REG_SZ /d "native, builtin" /f
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "shdoclc" /t REG_SZ /d "native, builtin" /f
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "shdocvw" /t REG_SZ /d "native, builtin" /f
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "urlmon" /t REG_SZ /d "native, builtin" /f
${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Wine\DllOverrides" /v "inetcpl.cpl" /t REG_SZ /d "native, builtin" /f

env LC_ALL="en_US.UTF-8" ${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --untrusted --wait-children --no-convert --new-console --dll 'msxml3=n' -- 'msiexec.exe' '/i' '/tmp/msxml3.msi' '/quiet'

# Remove the fake DLLs from the existing WINEPREFIX
if [ -f "${HOME}/.cxoffice/${BOTTLE}/drive_c/Program Files/Internet Explorer/iexplore.exe" ]; then
    if grep -q -i "wine placeholder" "${HOME}/.cxoffice/${BOTTLE}/drive_c/Program Files/Internet Explorer/iexplore.exe"; then
        echo 'unregserver iexplore'
        ${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --untrusted --wait-children --no-convert --new-console iexplore -unregserver
    fi
    echo 'backup iexplore.exe'
    mv "${HOME}/.cxoffice/${BOTTLE}/drive_c/Program Files/Internet Explorer/iexplore.exe" "${HOME}/.cxoffice/${BOTTLE}/drive_c/Program Files/Internet Explorer/iexplore.exe.bak"
fi

# See https://bugs.winehq.org/show_bug.cgi?id=16013
mkdir -p "${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/catroot/{f750e6c3-38ee-11d1-85e5-00c04fc295ee}"
sudo mv /tmp/installers/exe/winetest.cat "${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/catroot/{f750e6c3-38ee-11d1-85e5-00c04fc295ee}/oem0.cat" && sudo chown ${UID}:${GID} "${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/catroot/{f750e6c3-38ee-11d1-85e5-00c04fc295ee}/oem0.cat"

env LC_ALL="en_US.UTF-8" ${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --untrusted --wait-children --no-convert --new-console --dll 'iexplore.exe=n' '--' '/tmp/installers/exe/IE8-WindowsXP-x86-ENU.exe' '/passive' '/update-no' '/forcerestart'

# Work around DLL registration bug until ierunonce/RunOnce/wineboot is fixed
# FIXME: whittle down this list
for i in actxprxy.dll browseui.dll browsewm.dll cdfview.dll ddraw.dll dispex.dll dsound.dll iedkcs32.dll iepeers.dll iesetup.dll imgutil.dll inetcomm.dll isetup.dll jscript.dll laprxy.dll mlang.dll msctf.dll mshtml.dll mshtmled.dll msi.dll msimtf.dll msident.dll msoeacct.dll msrating.dll mstime.dll msxml3.dll occache.dll ole32.dll oleaut32.dll olepro32.dll pngfilt.dll quartz.dll rpcrt4.dll rsabase.dll rsaenh.dll scrobj.dll scrrun.dll shdocvw.dll shell32.dll urlmon.dll vbscript.dll webcheck.dll wshcon.dll wshext.dll asctrls.ocx hhctrl.ocx mscomct2.ocx plugin.ocx proctexe.ocx tdc.ocx uxtheme.dll webcheck.dll wshom.ocx; do
    ${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" regsvr32 /i $i 2>&1
done

${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "TabProcGrowth" /t REG_DWORD /d "00000000" /f

# env LC_ALL="en_US.UTF-8" ${INSTALLDIR}/bin/wine --bottle "${BOTTLE}" --untrusted --wait-children --no-convert --new-console -- '/tmp/installers/exe/IE8-WindowsXP-KB2936068-x86-ENU.exe' '/quiet' '/forcerestart'
# case $? in
#   0|194) echo "IE8-WindowsXP-KB2936068-x86-ENU installation successfully"
#     ;;
#   *) echo "IE8-WindowsXP-KB2936068-x86-ENU installation failed"
#     ;;
# esac

${INSTALLDIR}/bin/cxassoc --bottle ${BOTTLE} --sync
# 开始菜单快捷方式
${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --wait-children --wl-app cxmklnk.exe -- --lnkfile 'C:\users\crossover\Start Menu//Internet Explorer.lnk' --target 'C:\Program Files/Internet Explorer/iexplore.exe'
${INSTALLDIR}/bin/cxmenu --bottle ${BOTTLE} --sync --mode 'install'
${INSTALLDIR}/bin/cxassoc --bottle ${BOTTLE} --sync --sync-mode --mode 'mime;default=\.asx:\.wma:\.wmx:\.asf:\.wm:\.wmv:\.wax;alternative=\.avi:\.mov:\.qt'
${INSTALLDIR}/bin/cxnsplugin --bottle ${BOTTLE} --sync --mode 'ignore'
# ${INSTALLDIR}/bin/wine --scope 'private' --no-convert --wl-app 'assocscan.exe' --scan --icon-dir '/home/crossover/.cxoffice/BaiduNetDisk/windata/Associations'
# ${INSTALLDIR}/bin/wine --scope 'private' --wl-app 'pluginserver.exe' '--scandlls'

#  wget https://raw.githubusercontent.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/master/BaiduNetdisk/BaiduNetdisk.tar.xz -O /tmp/BaiduNetdisk.tar.xz && \
tar -Jxf /tmp/installers/BaiduNetdisk.tar.xz -C ${HOME}/.cxoffice/${BOTTLE}/drive_c/Program\ Files/
sudo mv /tmp/installers/dll/riched20.dll ${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/
sudo mv /tmp/installers/dll/riched32.dll ${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/