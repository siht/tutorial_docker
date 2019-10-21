# proyecto de ejemplo para levantar docker

Este proyecto muestra como levantar docker a nivel comando para reemplazarlos con un docker-compose.yml

Advertencia, necesitas navegar en el log de git para ver los cambios y el por que de tales cambios

## requerimientos

- aplicación de node que requiera de mongo (aquí una hecha)[repo](https://github.com/siht/node_api_test)
- según el [repo](https://github.com/siht/node_api_test), necesitamos:
    - node: 10.16.3
    - mongo: 4.0.3

## instrucciones

para ver este proyecto, deberás ver a través de las historia de git. de momento es una receta docker que levanta una base datos, una aplicación tipo api, y un reverse proxy.

modo base
```bash
$ docker-compose up
```

modo producción
```
$ docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
```
