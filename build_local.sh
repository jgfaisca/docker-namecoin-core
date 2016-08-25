
#!/bin/bash
#
# Build local docker image
#

# Image name
IMG="zekaf/namecoin-core"

# Image tag
TAG="latest"

# Build image
docker build -t $IMG:$TAG .
