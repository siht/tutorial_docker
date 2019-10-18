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

crearemos la red en común de tipo bridge (la default) con el fin de que nuestros contenedores puedan encontrarse por nombre (el cual tampoco fue definido y a continuación lo haremos) y añadiremos la opción network también

```bash
docker network create red_comun

## docker run -d node_app_api # -d detached o background
## docker run -d mongo:4.0.3 # -d detached o background
docker run -d --name api --network red_comun node_app_api
docker run -d --name db --network red_comun mongo:4.0.3
```

de esta manera ambos contenedores pertenecen a la misma red y se pueden encontrar via dns con su nombre de contenedor (api y db)