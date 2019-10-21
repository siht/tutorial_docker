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

En este paso ya tenemos nuestro docker-compose.yml ahora vamos a definir nuestra base de datos

versión antigua

```yml
version: '3'

services:
  db:
  api:

volumes:
  mongo_data:
```

versión con db definida

```yaml
version: '3'

services:
  db:
    image: mongo:4.0.10
    volumes:
      - mongo_data:/data/db
  api:

volumes:
  mongo_data:
```

como vemos la diferencia entre como habíamos definido el contenedor de la base de datos

```bash
docker run -d --name db --network red_comun -v mongo_data:/data/db mongo:4.0.3
```

vs compose

```yaml
  db:
    image: mongo:4.0.10
    volumes:
      - mongo_data:/data/db
```

mucho más legible