#!/bin/bash
#
#
echo "Grid-ftp: Starting..."
/etc/init.d/globus-gridftp-server start -data_interface "${PUBLIC_IP}"
retVal=$?
if [ ! $? -eq 0 ]; then
    echo "Grid-ftp: Error starting, return code $retVal"
    return $retVal
fi
echo "Grid-ftp: Started!"

sleep infinity
