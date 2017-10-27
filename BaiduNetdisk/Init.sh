#!/bin/bash

INSTALLDIR=/opt/cxoffice
BOTTLE=BaiduNetDisk
WINE="${INSTALLDIR}/bin/wine --bottle ${BOTTLE}"
echo $WINE
RE_TAG="Source Han Sans SC Regular"

${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "@MS UI Gothic" /t REG_SZ /d "@Ume UI Gothic" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "Arial" /t REG_SZ /d "MS Sans Serif" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "Arial Unicode MS" /t REG_SZ /d "Noto Sans CJK SC Regular" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "Batang" /t REG_SZ /d "UnBatang" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "DFKai-SB" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "Dotum" /t REG_SZ /d "UnDotum" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "FangSong" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "Gulim" /t REG_SZ /d "UnDotum" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "KaiTi" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "Lucida Console" /t REG_SZ /d "MS Sans Serif" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "Microsoft JhengHei" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "Microsoft YaHei" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "MingLiU" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "MS Gothic" /t REG_SZ /d "Ume Gothic" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "MS Mincho" /t REG_SZ /d "Ume Mincho" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "MS PGothic" /t REG_SZ /d "Ume P Gothic" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "MS PMincho" /t REG_SZ /d "Ume P Mincho" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "MS UI Gothic" /t REG_SZ /d "Ume UI Gothic" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "NSimSun" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "PMingLiU" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "SimHei" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "SimKai" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "SimSun" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "仿宋" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "仿宋_GB2312" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "宋体" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "微软雅黑" /t REG_MULTI_SZ /d "Source Han Sans Normal" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "新宋体" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "新細明體" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "楷体" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "楷体_GB2312" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "隶书" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "黑体" /t REG_MULTI_SZ /d "WenQuanYi Micro Hei" /f
${WINE} Reg.exe add "HKCU\Software\Wine\Fonts\Replacements" /v "ＭＳＰゴシック" /t REG_SZ /d "Ume P Gothic" /f
if [ -n "$2" ]; then
    RE_TAG="$2"
fi
