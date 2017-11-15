#!/bin/bash

sudo docker stop $(sudo docker ps -q --filter status=running)
cid=$(sudo docker run -d --security-opt seccomp:unconfined -p 5901:5901 johnshine/baidunetdisk-crossover-vnc:1.1)
sudo docker cp Init.sh ${cid}:/home/crossover/.cxoffice/Init.sh
