
#!/bin/bash
#
# Build local docker image
#

# Docker image
IMG="zekaf/namecoin-core"
TAG="latest"

# Build image
docker build -t $IMG:$TAG .
