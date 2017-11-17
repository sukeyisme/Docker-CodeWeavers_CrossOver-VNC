#!/bin/bash

# sudo docker run -d -p 5901:5901 johnshine/idm-crossover-vnc:1.0

# The following is for test
running=$(sudo docker ps -q --filter status=running)
if [[ ! -z $running ]]; then
    sudo docker stop ${running}
fi

sudo docker run -d -p 5901:5901 johnshine/idm-crossover-vnc:1.0
