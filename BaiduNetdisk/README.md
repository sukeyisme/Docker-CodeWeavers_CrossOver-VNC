# 百度云客户端的docker镜像

docker hub的repo地址：https://hub.docker.com/r/johnshine/baidunetdisk-crossover-vnc/

群晖NAS的福音来了，直接在docker中启动百度云客户端，通过VNC客户端远程管理，不需要再运行臃肿的虚拟机系统了；

## 快速上手

pull镜像到本地

`sudo docker pull johnshine/baidunetdisk-crossover-vnc:latest`

启动镜像，就会在5901端口开启vnc远程连接端口。第一个5901是VNC连接的端口，你可以改成其它数字，如果冲突的话

`sudo docker docker run -d -p 5901:5901 johnshine/baidunetdisk-crossover-vnc:latest`

或者，你也可以指定vnc远程连接的密码方式启动

`sudo docker docker run -d -p 5901:5901 -e vnc_password=your_password johnshine/baidunetdisk-crossover-vnc:latest`

还可以绑定默认下载目录到host的某个目录，会自动创建一个

`sudo docker docker run -d -p 5901:5901 -v /path/to/download/folder:/mnt/drive_d johnshine/baidunetdisk-crossover-vnc:latest`

使用VNC客户端连接5901端口即可

## VNC客户端推荐

1. jump desktop
2. TightVNC

##    

![截图](https://raw.githubusercontent.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/master/BaiduNetdisk/screenshot/1.png)

## 已知问题

+ 无法修改容器内的下载路径为其它路径

## 已克服问题

+ 字体乱码
+ 用户名、密码无法输入
+ 第三方网页登录被阻止
+ 闪退

## 版权声明

本项目引用的百度云客户端归“北京百度网讯科技有限公司”所有，CrossOver归CodeWeavers Inc所有，其它遵从GPL协议
