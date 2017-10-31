# CodeWeavers.CrossOver.VNC Docker image
A docker image for run CrossOver though VNC remote manage.

`sudo docker run -d -p ${VNC_PORT}:5901 -e vnc_password=${YOUR_VNC_PASSWORD} johnshine/crossover-vnc：latest`


## Change history

1.1
* change install directory
* decrease image size
* fix issue: vncserver start at another port.


1.0
* initialized
