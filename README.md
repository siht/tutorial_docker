# proyecto de ejemplo para levantar docker

Este proyecto muestra como levantar docker a nivel comando para reemplazarlos con un docker-compose.yml

Advertencia, necesitas navegar en el log de git para ver los cambios y el por que de tales cambios

## requerimientos

- aplicación de node que requiera de mongo (aquí una hecha)[repo](https://github.com/siht/node_api_test)
- según el [repo](https://github.com/siht/node_api_test), necesitamos:
    - node: 10.16.3
    - mongo: 4.0.3

## instrucciones

El siguiente paso es de mejora, puesto que a todos nos han enseñado que la información sensible jamás debe viajar por internet, debemos usar variables de entorno, docker-compose autmáticamente carga el archivo ".env" que esté junto a al docker-compose.yml, así que agregaremos ese archivo con este contenido

```
# este es el contenido del archivo ".env"
MONGO=mongodb://db:27017/Profile
IMGUR_CLIENT_ID=un_valor_x
PORT=8000
```

y modificaremos la parte de las variables de entorno de docker-compose.yml

```yaml
MONGO: mongodb://db:27017/Profile
IMGUR_CLIENT_ID: un_valor_x
PORT: 8000
```

por

```yaml
MONGO: ${MONGO}
IMGUR_CLIENT_ID: ${IMGUR_CLIENT_ID}
PORT: ${PORT}
```

y añadiremos un .gitignore

```gitignore
.env

```