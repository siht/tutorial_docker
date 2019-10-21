#!/bin/sh

docker build -t node_app_api .

docker network create red_comun

docker volume create mongo_data

docker run -d --name db --network red_comun -v mongo_data:/data/db mongo:4.0.3
docker run -d --name api --network red_comun -e "MONGO=mongodb://db:27017/Profile" -e "PORT=8000" -e "IMGUR_CLIENT_ID=un_valor_x" -p 8000:8000 node_app_api

