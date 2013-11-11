#!/bin/bash
# Properly builds and tags this image ready for use
# in other DockerFile's FROM statements
NAME=docker.dpaw.wa.gov.au/ubuntu
TAG=12.04
set -e
if [ "$1" == "export" ]; then
    docker export $(docker run -d $NAME:$TAG bash) | pv | gzip > $NAME-$TAG.tar.gz
elif [ "$1" == "push" ]; then
    docker push $NAME
else
    docker build $@ -t $NAME . 
    docker export $(docker run -d $NAME bash) | pv | docker import - $NAME:$TAG
fi