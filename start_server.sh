#!/bin/bash
#
# Requires that the HOSTNAME is configured

if [ -z ${PUBLIC_IP} ]; then
  export PUBLIC_IP=`dig +short $HOSTNAME`
  echo "PUBLIC_IP not set, setting IP to ${PUBLIC_IP}"
fi

docker-compose build
docker-compose up $1 -d 
