#!/bin/bash

docker-compose build -f ../build-container/docker-compose.yml
docker-compose push -f ../build-container/docker-compose.yml

