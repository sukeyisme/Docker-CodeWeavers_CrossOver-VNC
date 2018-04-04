# Using CentOS 7 base image and VNC
# Version 1.0

FROM centos:7
MAINTAINER john.shine <mr.john.shine@gmail.com>
LABEL io.openshift.expose-services="5901:tcp"

USER root

ENV DISPLAY=":1"
ENV USER="crossover"
ENV UID=100
ENV GID=0
ENV HOME=/home/${USER}
ENV INSTALLDIR=/opt/cxoffice
ARG vnc_password=""
EXPOSE 5901

ADD xstartup ${HOME}/.vnc/

RUN /bin/dbus-uuidgen --ensure
RUN useradd -g ${GID} -u ${UID} -r -d ${HOME} -s /bin/bash ${USER}
RUN echo "root:root" | chpasswd
# set password of ${USER} to ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN yum check-update -y ; \
    yum install -y --setopt=tsflags=nodocs tigervnc-server xorg-x11-server-utils xorg-x11-server-Xvfb xorg-x11-fonts-* motif xterm && \
    yum install -y --setopt=tsflags=nodocs sudo which wget && \
    yum install -y --setopt=tsflags=nodocs freetype.i686 freetype.x86_64 glibc.i686 glibc.x86_64 libICE.i686 libICE.x86_64 libSM.i686 libSM.x86_64 libX11.i686 libX11.x86_64 libXext.i686 libXext.x86_64 libgcc.i686 libgcc.x86_64 libpng.i686 libpng.x86_64 nss-mdns.i686 nss-mdns.x86_64 pygtk2 zlib.i686 zlib.x86_64 && \
	/bin/echo -e "\n${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
    yum clean all && rm -rf /var/cache/yum/*

RUN touch ${HOME}/.vnc/passwd ${HOME}/.Xauthority

RUN chown -R ${UID}:${GID} ${HOME} && \
    chmod 775 ${HOME}/.vnc/xstartup && \
    chmod 600 ${HOME}/.vnc/passwd && \
    mkdir -p ${INSTALLDIR} && \
    chown -R ${UID}:${GID} ${INSTALLDIR}

WORKDIR ${HOME}

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

USER ${USER}

# Always run the WM last!
RUN /bin/echo -e "export DISPLAY=${DISPLAY}"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nxsetroot -solid grey"  >> ${HOME}/.vnc/xstartup
# install crossover
RUN /bin/echo -e "if [[ -f ${INSTALLDIR}/bin/crossover ]]; then" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    ${INSTALLDIR}/bin/crossover" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "else" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    wget https://media.codeweavers.com/pub/crossover/cxlinux/demo/install-crossover-16.2.5.bin -O /tmp/install-crossover-16.2.5.bin && chmod +x /tmp/install-crossover-16.2.5.bin && /tmp/install-crossover-16.2.5.bin --i-agree-to-all-licenses --destination ${INSTALLDIR} --noreadme --noprompt --nooptions && rm -f /tmp/install-crossover-16.2.5.bin" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "fi" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "if ls /tmp/install-crossover-*.bin 1> /dev/null 2>&1;" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    then rm -f /tmp/install-crossover-*.bin;" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "fi" >> ${HOME}/.vnc/xstartup

RUN /bin/echo -e 'alias ll="ls -last"' >> ${HOME}/.bashrc
