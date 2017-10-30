# 百度云客户端的docker镜像

docker hub的repo地址：https://hub.docker.com/r/johnshine/baidunetdisk-crossover-vnc/


## 快速上手

pull镜像到本地
`sudo docker pull johnshine/baidunetdisk-crossover-vnc:latest /bin/bash`

启动镜像，就会在5901端口开启vnc远程连接端口

`sudo docker docker run -d -p 5901:5901 johnshine/baidunetdisk-crossover-vnc:latest /bin/bash`

或者，你也可以指定vnc远程连接的密码方式启动
`sudo docker docker run -d -p 5901:5901 -e vnc_password=your_password johnshine/baidunetdisk-crossover-vnc:latest /bin/bash`

使用vnc连接5901端口即可

## VNC客户端推荐

1、jump desktop

##    

![截图](https://raw.githubusercontent.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/master/BaiduNetdisk/screenshot/1.png)

## 已知问题

暂无
