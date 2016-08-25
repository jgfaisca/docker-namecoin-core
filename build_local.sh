
#!/bin/bash
#
# Build docker image localy
#

# Docker image
IMG="zekaf/namecoin-core"
TAG="latest"

# Build image
docker build -t $IMG:$TAG .
