# proyecto de ejemplo para levantar docker

Este proyecto muestra como levantar docker a nivel comando para reemplazarlos con un docker-compose.yml

Advertencia, necesitas navegar en el log de git para ver los cambios y el por que de tales cambios

## requerimientos

- aplicación de node que requiera de mongo (aquí una hecha)[repo](https://github.com/siht/node_api_test)
- según el [repo](https://github.com/siht/node_api_test), necesitamos:
    - node: 10.16.3
    - mongo: 4.0.3

## instrucciones

En la recién creada carpeta src colocaremos el código del [repo](https://github.com/siht/node_api_test) (la rama master es perfectamente funcional) con la instrucción

```bash
cd src
git clone https://github.com/siht/node_api_test.git
```

## siguiente paso (esta descripción se va a borrar)

nuestra aplicación corre por el puerto 8000, pero no tiene salida a la red de nuestra computadora para poder probar, agregaremos un puerto de salida temporal (el 8000 también)

```bash
## docker run -d --name api --network red_comun -e "MONGO=mongodb://db:27017/Profile" -e "PORT=8000" node_app_api
# se agrega la opción p el primer numero es el puerto que se vincula a nuestra computadora
# el segundo es el puerto dentro de la red interna
docker run -d --name api --network red_comun -e "MONGO=mongodb://db:27017/Profile" -e "PORT=8000" -p 8000:8000 node_app_api
```

procedemos a entrar a "0.0.0.0:8000" o "127.0.0.1:8000" o "localhost:8000"