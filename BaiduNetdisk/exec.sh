#!/bin/bash

sudo docker exec -it $(sudo docker ps -q) /bin/bash
