# Using CentOS 6 base image and VNC
# Version 0.1

# Pull the rhl image from the local repository
FROM centos:7
MAINTAINER john.shine <mr.john.shine@gmail.com>
LABEL io.openshift.expose-services="5901:tcp"

USER root

ENV DISPLAY=":1"
ENV USER="crossover"
ENV HOME=/home/${USER}
ARG vnc_password=""
EXPOSE 5901

ADD xstartup ${HOME}/.vnc/

RUN /bin/dbus-uuidgen --ensure
RUN useradd -u 100 -r -g 0 -d ${HOME} -s /bin/bash ${USER} ; alias ll="ls -last"
RUN echo "root:root" | chpasswd
# set password of ${USER} to ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN yum check-update -y ; \
    yum install -y --setopt=tsflags=nodocs tigervnc-server xorg-x11-server-utils xorg-x11-server-Xvfb xorg-x11-fonts-* motif xterm && \
	yum install -y --setopt=tsflags=nodocs sudo which wget && \
	/bin/echo -e "\n${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
    yum clean all && rm -rf /var/cache/yum/*

RUN echo "${vnc_password}" | vncpasswd -f > ${HOME}/.vnc/passwd
RUN touch ${HOME}/.Xauthority

RUN chown -R 100:0 ${HOME} && \
    chmod 775 ${HOME}/.vnc/xstartup && \
    chmod 600 ${HOME}/.vnc/passwd

WORKDIR ${HOME}

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

USER ${USER}

# Always run the WM last!
RUN /bin/echo -e "export DISPLAY=${DISPLAY}"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nxsetroot -solid grey"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "xterm"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e 'alias ll="ls -last"' >> ${HOME}/.bash_profile
