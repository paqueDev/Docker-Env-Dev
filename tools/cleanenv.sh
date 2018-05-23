#!/bin/bash

#on stop tous les containers
docker stop $(docker ps -a -q)

# on supprime tous les containers stoppés
docker ps -aq --no-trunc -f status=exited | xargs docker rm

# on supprime les images inutiles
docker images -q --filter dangling=true | xargs docker rmi

# on supprime les volumes utilisés
docker volume rm $(docker volume ls -qf dangling=true)