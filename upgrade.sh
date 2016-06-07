#!/usr/bin/env bash

SERVICE=${1:-mc}

docker-compose kill "$SERVICE"
docker-compose rm -f "$SERVICE"
docker-compose pull "$SERVICE"
docker-compose up -d
