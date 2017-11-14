#!/bin/bash

sudo docker run -d --security-opt seccomp:unconfined -p 5901:5901 johnshine/baidunetdisk-crossover-vnc:1.1
