#!/bin/bash

while true; do
    INSTALLDIR="$(echo -e "${INSTALLDIR}" | sed -e 's/[[/]]*$//')"
    if pid=$(pgrep -f "python ${INSTALLDIR}/bin/crossover"); then
        echo "process is running"
        kill $pid
        break
    else
        echo "process is not running"
    fi
    sleep 5
done
