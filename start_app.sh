#!/bin/sh

docker build -t node_app_api .

# generar contenedores
# se les define un nombre porque al generar un nuevo contenedor cambia su dirección ip
# dentro de la red interna de docker
docker run -d --name api --network red_comun node_app_api
docker run -d --name db --network red_comun mongo:4.0.3
