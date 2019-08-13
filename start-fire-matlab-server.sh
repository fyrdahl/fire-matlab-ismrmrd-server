#!/bin/sh

if [ $# -eq 1 ]; then
    LOG_FILE=${1}
    octave-cli --eval "cd /opt/code/fire-matlab-ismrmrd-server/; fire_matlab_ismrmrd_server(9002,'${LOG_FILE}')"
else
    octave-cli --eval "cd /opt/code/fire-matlab-ismrmrd-server/; fire_matlab_ismrmrd_server(9002)"
fi
