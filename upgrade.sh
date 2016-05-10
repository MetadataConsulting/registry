#!/usr/bin/env bash

docker-compose kill mc
docker-compose rm -f mc
docker-compose pull mc
docker-compose up -d
