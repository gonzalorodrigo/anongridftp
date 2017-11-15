#!/bin/bash
#
#
echo "Grid-ftp: Starting..."
echo "data_interface $PUBLIC_IP" >> /etc/gridftp.conf
/etc/init.d/globus-gridftp-server start
retVal=$?
if [ ! $? -eq 0 ]; then
    echo "Grid-ftp: Error starting, return code $retVal"
    return $retVal
fi
echo "Grid-ftp: Started!"

sleep infinity
