#!/bin/sh

docker rm -f $(docker ps -aq)

docker volume rm $(docker volume ls)

docker network prune
