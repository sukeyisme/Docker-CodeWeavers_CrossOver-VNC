# Using CentOS 7 base image and VNC
# Version 1.0

FROM centos:7
MAINTAINER john.shine <mr.john.shine@gmail.com>
LABEL io.openshift.expose-services="5901:tcp"

USER root

ENV DISPLAY=":1"
ENV USER="crossover"
ENV HOME=/home/${USER}
ENV BOTTLE="BaiduNetDisk"
ENV INSTALLDIR="/opt/cxoffice"
ARG vnc_password=""
EXPOSE 5901

ADD xstartup ${HOME}/.vnc/
ADD install-crossover-16.2.5.bin /tmp/install-crossover-16.2.5.bin
ADD kill.sh /tmp/kill.sh
ADD default ${HOME}/.cxoffice/${BOTTLE}_back

RUN /bin/dbus-uuidgen --ensure
RUN useradd -u 100 -r -g 0 -d ${HOME} -s /bin/bash ${USER}
RUN echo "root:root" | chpasswd
# set password of ${USER} to ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN yum check-update -y ; \
    yum install -y --setopt=tsflags=nodocs tigervnc-server xorg-x11-server-utils xorg-x11-server-Xvfb xorg-x11-fonts-* motif xterm && \
    yum install -y --setopt=tsflags=nodocs sudo which wget && \
    yum install -y --setopt=tsflags=nodocs libv4l.i686 fontconfig.i686 libXcomposite.i686 libXinerama.i686 libgphoto2.i686 libxml2.i686 libxslt.i686 openldap.i686 sane-backends-libs.i686 mesa-dri-drivers.i686 isdn4k-utils.i686 gsm.i686 gstreamer-plugins-base.i686 lcms2.i686 mesa-libOSMesa.i686 libtiff.i686 gnutls.i686 glibc.i686 zlib.i686 freetype.i686 libgcc.i686 libXext.i686 alsa-lib.i686 cups-libs.i686 dbus-libs.i686 libXcursor.i686 libXi.i686 libXrandr.i686 libXrender.i686 libXxf86vm.i686 openssl.i686 libpng.i686 libX11.i686 mesa-libGL.i686 freetype.x86_64 glibc.x86_64 libICE.i686 libICE.x86_64 libSM.i686 libSM.x86_64 libX11.x86_64 libXext.x86_64 libgcc.x86_64 libpng.x86_64 nss-mdns.i686 nss-mdns.x86_64 pygtk2 zlib.x86_64 && \
	/bin/echo -e "\n${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
    yum clean all && rm -rf /var/cache/yum/*

RUN echo "${vnc_password}" | vncpasswd -f > ${HOME}/.vnc/passwd
RUN touch ${HOME}/.Xauthority

RUN chown -R 100:0 ${HOME} && \
    chmod 775 ${HOME}/.vnc/xstartup && \
    chmod 600 ${HOME}/.vnc/passwd && \
    chmod +x /tmp/install-crossover-16.2.5.bin

WORKDIR ${HOME}

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p ${INSTALLDIR} && \
    chown -R 100:0 ${INSTALLDIR} && \
    export INSTALLDIR="${INSTALLDIR}"

ENTRYPOINT ["/entrypoint.sh"]

USER ${USER}

# Always run the WM last!
RUN /bin/echo -e "export DISPLAY=${DISPLAY}"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nxsetroot -solid grey"  >> ${HOME}/.vnc/xstartup
# install crossover
RUN /bin/echo -e "if [[ ! -f ${INSTALLDIR}/bin/crossover ]]; then" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    sudo chmod +x /tmp/kill.sh && /tmp/kill.sh &" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    /tmp/install-crossover-16.2.5.bin --i-agree-to-all-licenses --destination ${INSTALLDIR} --noreadme --noprompt --nooptions" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "fi" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "if [[ ! -d ${HOME}/.cxoffice/${BOTTLE}/ ]]; then" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    ${INSTALLDIR}/bin/cxbottle --create --bottle \"BaiduNetDisk\" --description \"百度网盘wine容器\" --template \"winxp\"" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    mv ${HOME}/.cxoffice/${BOTTLE}_back/drive_c/Program\ Files/baidu/ ${HOME}/.cxoffice/${BOTTLE}/drive_c/Program\ Files/baidu/" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "fi" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "env WINEPREFIX=\"${HOME}/.cxoffice/${BOTTLE}/\" ${INSTALLDIR}/bin/wine --bottle ${BOTTLE}  \"c:\\\\\\\\Program Files\\\\\\\\baidu\\\\\\\\BaiduNetdisk\\\\\\\\baidunetdisk.exe\"" >> ${HOME}/.vnc/xstartup

# RUN /bin/mv "${HOME}/.cxoffice/${BOTTLE}/drive_c/users/@current_user@" "${HOME}/.cxoffice/${BOTTLE}/drive_c/users/${USER}"
# RUN /bin/sed -i "s#@current_user@#$USER#" ${HOME}/.cxoffice/${BOTTLE}/*.reg
RUN /bin/echo -e 'alias ll="ls -last"' >> ${HOME}/.bashrc
