#!/bin/bash
#
# Create docker container
#

# Random password function
function randomPass(){
  < /dev/urandom tr -dc _#A-Z-a-z-0-9 | head -c${1:-32};echo;
}

# Random user function
function randomUser(){
  < /dev/urandom tr -dc a-z-0-9 | head -c${1:-8};echo;
}

# Docker image
IMG="zekaf/namecoin-core"

# Image tag
TAG="latest"

# Host directory
HOSTDIR="/opt/docker/data"

# Namecoin container
NMC_CT="namecoin-core"

# Namecoin IP
NMC_IP="10.17.0.2"

# Docker network (isolated network)
RPC_ALLOW_IP="10.17.0.0/16"

# RPC user & password
RPC_USER=$(randomUser)
RPC_PASS=$(randomPass)

# Create docker container
docker run -d \
  --net isolated_nw --ip $NMC_IP \
  --name $NMC_CT \
  --restart=always \
  --volume=/opt/docker/volumes/namecoin-core/namecoin:/data/namecoin \
  -e RPC_USER=$RPC_USER \
  -e RPC_PASS=$RPC_PASS \
  -e RPC_ALLOW_IP=$RPC_ALLOW_IP \
  -e MAX_CONNECTIONS=10 \
  -e RPC_PORT=8336 \
  -e PORT=8334 \
  $IMG:$TAG
