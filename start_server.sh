#!/bin/bash
#
# Requires that the HOSTNAME is configured

export PUBLIC_IP=`dig +short $HOSTNAME`

docker-compose build
docker-compose up $1 -d 
