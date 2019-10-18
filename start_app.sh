#!/bin/sh

docker build -t node_app_api .

docker create network red_comun

docker run -d --name api --network red_comun -e "MONGO=mongodb://db:27017/Profile" -e "PORT=8000" -p 8000:8000 node_app_api
docker run -d --name db --network red_comun mongo:4.0.3
