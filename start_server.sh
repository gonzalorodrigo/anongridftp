#!/bin/bash
#
# Requires that the HOSTNAME is configured

export PUBLIC_IP=`dig +short $HOSTNAME`
# example on hot to reduce the number of ports
export GLOBUS_HI_DATA_TCP_PORT=50100
export GLOBUS_LOW_DATA_TCP_PORT=50000
export GLOBUS_TCP_PORT_RANGE=50000,50100

docker-compose up $1
