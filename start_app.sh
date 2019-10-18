#!/bin/sh

docker build -t node_app_api .

# generar contenedores
docker run -d node_app_api # -d detached o background
docker run -d mongo:4.0.3 # -d detached o background
