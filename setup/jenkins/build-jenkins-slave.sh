#!/bin/bash

EXPORT REPO=$1
docker-compose build -f ../build-container/docker-compose.yml
docker-compose push -f ../build-container/docker-compose.yml

