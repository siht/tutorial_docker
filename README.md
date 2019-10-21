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

En este paso ya tenemos nuestra base de datos ahora vamos a definir nuestra api

versión antigua

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

versión con api definida

```yaml
version: '3'

services:
  db:
    image: mongo:4.0.10
    volumes:
      - mongo_data:/data/db
  api:
    build:
      context: ./src/node_api_test
      dockerfile: ../../Dockerfile
    depends_on:
      - db
volumes:
  mongo_data:
```

como nuestra aplicación es "construida" (por eso hay que añadir build) por un dockerfile, necesitamos decirle desde donde va a tomar los recursos (context) y si el dockerfile no esta dentro del contexto, especificar donde se encuentra tomando como referencia el contexto, además especificar si hay dependencias a otrso contenedores.

desde este momento, nuestro status es que ya podemos correr nuestra receta de docker-compose, de hecho ya incluimos todos los pasos que incluimos en el script bash.

podemos construir todo antes de correr las aplicaciones

```bash
# ejecutar en el directorio donde está el docker-compose.yml
$ docker-compose build
# o construir por servicio
$ docker-compose build api
# varios servicios
$ docker-compose build api db
```

pero si lo haces por primera ocasión, no necesitas especificar la contrucción, automáticamente se construirán

```bash
$ docker-compose up
# o construir explícitamente
$ docker-compose up --build
```

al correr la aplicación esta no correrá porque faltan las variables de entorno, no necesitamos reconstruir las imagenes, sólo hay que eliminar los contenedores:

```bash
$ docker-compose down # para y elimina los contenedores
```

modificamos nuestro docker-compose.yml


```yaml
version: '3'

services:
  db:
    image: mongo:4.0.10
    volumes:
      - mongo_data:/data/db
  api:
    build:
      context: ./src/node_api_test
      dockerfile: ../../Dockerfile
    depends_on:
      - db
    environment:
      MONGO: mongodb://db:27017/Profile
      IMGUR_CLIENT_ID: un_valor_x
      PORT: 8000
volumes:
  mongo_data:
```

el cual si correrá, como no se hizo cambio en el dockerfile no es necesario construir una nueva imagen

```bash
$ docker-compose up
```

pero el navegador no nos mostrará resultados, porque no añadimos la directiva ports en el servicio de api, reescribiremos

```yaml
version: '3'

services:
  db:
    image: mongo:4.0.10
    volumes:
      - mongo_data:/data/db
  api:
    build:
      context: ./src/node_api_test
      dockerfile: ../../Dockerfile
    depends_on:
      - db
    environment:
      MONGO: mongodb://db:27017/Profile
      IMGUR_CLIENT_ID: un_valor_x
      PORT: 8000
    ports:
      - 8000:8000
volumes:
  mongo_data:
```

y correremos estos comando una vez más:

```bash
$ docker-compose down
$ docker-compose up
```

ahora nuestra aplicación está corriendo perfectamente

```bash
$ curl localhost:8000/profiles
$ curl -d '{"nombre":"haku", "titulo":"dios sin nombre", "descripcion": "aparece en el viaje de chihiro"}' -H "Content-Type: application/json" -X POST http://localhost:8000//profile/new
```