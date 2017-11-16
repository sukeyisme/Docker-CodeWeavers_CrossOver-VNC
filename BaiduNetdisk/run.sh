#!/bin/bash

sudo docker run -d -p 5901:5901 johnshine/baidunetdisk-crossover-vnc:1.1

# The following is for test
# running=$(sudo docker ps -q --filter status=running)
# if [[ ! -z $running ]]; then
#     sudo docker stop ${running}
# fi

# mkdir -p ./BaiduNetdiskDownload/
# cid=$(sudo docker run -d --security-opt seccomp:unconfined -v `pwd`/BaiduNetdiskDownload:/mnt/drive_d -p 5901:5901 johnshine/baidunetdisk-crossover-vnc:1.1)
# sudo docker cp Init.sh ${cid}:/home/crossover/.cxoffice/Init.sh
