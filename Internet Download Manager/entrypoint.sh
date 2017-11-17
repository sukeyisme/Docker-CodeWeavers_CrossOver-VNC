#!/bin/sh

[ -z "${DISPLAY}" ] || /usr/bin/vncserver -kill ${DISPLAY}; sudo rm -f /tmp/.X*-lock; sudo rm -rf /tmp/.X11-unix/; sleep 2
/usr/bin/vncserver -geometry 1024x800 -fg
