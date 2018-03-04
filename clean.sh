#!/bin/bash
eval $(docker-machine env readus)
docker rm -f $(docker ps -a -q)
docker rmi $(docker images -q)
