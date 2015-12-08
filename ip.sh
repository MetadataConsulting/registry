#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ] || [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] ; then
    DOCKER_MACHINE_IP="${DOCKER_HOST/tcp:\/\//}"
    DOCKER_MACHINE_IP="${DOCKER_MACHINE_IP/:2376/}"
    echo "Using preset IP: $DOCKER_MACHINE_IP"
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    # set by docker machine on other system
    echo "Finding IP: $DOCKER_MACHINE_IP"
    DOCKER_MACHINE_IP=$(dig +short myip.opendns.com @resolver1.opendns.com || ip route get 8.8.8.8 | head -1 | cut -d' ' -f8 || ip a s|sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')
fi

echo -e "# this file is managed automatically by init.sh script do not edit manually\nVIRTUAL_HOST=$DOCKER_MACHINE_IP" > ip.env
