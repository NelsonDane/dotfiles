#!/bin/bash

# This script will be ran with source

# IP
DOCKER_USER="builder"
DOCKER_IP="dockerbuilder.lan"

# Check args
if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    return 1
fi

# Status
if [ $1 = "status" ]; then
    if [ -z ${DOCKER_HOST+x} ]; then
        echo "Docker host is not set"
    else
        echo "Docker host is set to $DOCKER_HOST"
    fi
    return 0

elif [ $1 = "on" ]; then
    # Check if host is reachable and Docker is running
    if ping -c 1 $DOCKER_IP &> /dev/null && docker info &> /dev/null; then
        echo "Host is reachable and Docker is running. Setting DOCKER_HOST..."
        export DOCKER_HOST="ssh://$DOCKER_USER@$DOCKER_IP"
    else
        echo "Host is not reachable or Docker is not running"
        return 1
    fi

elif [ $1 = "off" ]; then
    unset DOCKER_HOST
    echo "DOCKER_HOST unset"
else
    echo "Invalid argument"
    return 1
fi