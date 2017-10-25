#!/bin/bash

#   Copyright (C) 2016 Deepin, Inc.
#
#   Author:     Peng Hao <penghao@linuxdeepin.com>
#   Maintainer: Peng Hao <penghao@linuxdeepin.com>

BASE_DIR="$HOME/.deepinwine/Deepin-BaiduNetDisk"
WINE_CMD="deepin-wine"
EXIT_TIME=$(( $(date +%s) + 1500 ))

_SetRegistryValue()
{
    env WINEPREFIX="$BASE_DIR" $WINE_CMD reg ADD "$1" /v "$2" /t $3 /d "$4"
}

_SetOverride()
{
    _SetRegistryValue 'HKCU\Software\Wine\DllOverrides' "$2" REG_SZ "$1"
}

if [ -f $HOME/.deepinwine/.baidunetdisk.exe ]; then
    echo "baidunetdisk.exe is running"
else
    /opt/deepinwine/tools/kill.sh baidunetdisk.exe block
fi

touch $HOME/.deepinwine/.baidunetdisk.exe

env WINEPREFIX="$BASE_DIR" $WINE_CMD "c:\\Program Files\\baidu\\BaiduNetdisk\\baidunetdisk.exe" &

while (( $(date +%s) < $EXIT_TIME )) ; do
   PROCESS=$(ps -ef | grep baidunetdisk.exe | grep -v "grep")
   WINDOWS=$(xwininfo -root -children | grep Wine | grep baidunetdisk.exe | grep -v "has no name")

   if [[ -n "$PROCESS"  &&  -n "$WINDOWS" ]]; then
        echo "Start finshed"
        if [ -f $HOME/.deepinwine/.baidunetdisk.exe ]; then
            rm $HOME/.deepinwine/.baidunetdisk.exe
        fi
        exit 0
    fi
done

exit 0
