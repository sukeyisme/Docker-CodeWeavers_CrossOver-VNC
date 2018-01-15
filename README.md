# CodeWeavers.CrossOver.VNC Docker image
A docker image for run CrossOver though VNC remote manage.

`sudo docker run -d -p ${VNC_PORT}:5901 -e vnc_password=${YOUR_VNC_PASSWORD} johnshine/crossover-vnc:latest`


使用优惠码：CYBERSTEAL9 购买CrossOver Linux一次性版只需9美元

With promotion Code: CYBERSTEAL9, purchase CrossOver Linux single version only for $9

使用授权证书激活, 证书可以在codeweavers.com官网，我的帐号->我的帐号->我的订单内下载

Activated by license file, license file can be downloaded on codeweavers.com -> My Account -> My Orders

`sudo docker run -d -p ${VNC_PORT}:5901 -v /path/to/license/license.sig:/opt/cxoffice/etc/license.sig -v /path/to/license/license.txt:/opt/cxoffice/etc/license.txt -e vnc_password=${YOUR_VNC_PASSWORD} johnshine/crossover-vnc:latest`

如果你对这个项目感兴趣，希望表达一份感谢之情，请打开支付宝<a href="https://mobile.alipay.com/index.htm" target="_blank"><img src="https://raw.githubusercontent.com/john-shine/DIY-iMac-CN/master/images/alipay.png" width="18"></a>扫描下面的二维码，你和我都将获得一份支付宝红包

![红包二维码](https://raw.githubusercontent.com/john-shine/DIY-iMac-CN/master/images/barcode.png)

## Change history

1.1
* change install directory
* decrease image size
* fix issue: vncserver start at another port.


1.0
* initialized
