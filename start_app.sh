#!/bin/sh

docker build -t node_app_api .

# se agregan también variables de entorno 
docker run -d --name api --network red_comun -e "MONGO=mongodb://db:27017/Profile" -e "PORT=8000" node_app_api
docker run -d --name db --network red_comun mongo:4.0.3
