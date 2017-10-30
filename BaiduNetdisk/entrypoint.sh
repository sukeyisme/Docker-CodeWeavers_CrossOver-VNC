#!/bin/sh

[ -z "${DISPLAY}" ] || /usr/bin/vncserver -kill ${DISPLAY}; rm -f /tmp/.X*-lock; rm -rf /tmp/.X11-unix/; sleep 2
/usr/bin/vncserver -geometry 1920x1080 -fg
