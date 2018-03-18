#!/bin/bash
machine=readus
eval $(docker-machine env $machine)

container=$1
if [[ -z "$container" ]]; then
    container=tornado
fi

container_id=$(docker ps | grep $container | head -n1 | awk '{ print $1 }')

if [[ -z "$container_id" ]]; then
    echo "Couldn't find container $container"
    exit 1
fi

docker exec -it $container_id bash

