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

perfecto, sólo falta agregar un volumen para persistir los datos de la base de datos, si reconstruyes las imagenes de las bases de datos debes reconstruir los contenedores, eso quiere decir que también los datos son nuevos (se borra todo).

Los contenedores son un conjunto de programas y datos todo en uno, pero como son un sistema linux veremos a los volúmenes como un dispositivo en linux que se tiene que montar [recurso online](https://blog.carreralinux.com.ar/2016/07/montar-dispositivos-de-almacenamiento-linux/) (si el recurso no está disponible buscar comando mount o "archivo /etc/fstab").

recuerda que hay dos tipos de volúmenes de tipo interno y externo:

- interno, los maneja docker y puedes administrarlos mediante el comando "docker volume"
- externo, pertenece a tu sistema de ficheros y puedes acceder como cualquier directorio o archivo

**IMPORTANTE**
**en versiones antiguas de docker no existian volúmenes y se creaban contenedores de datos (por si te encuentras con una receta sin volúmenes pero con contenedores extra)**

Después de toda esa explicación antes de poner a correr el contenedor de la base de datos primero detén y elimina los contenedores, ejecuta en la consola el siguiente comando

```bash
$ docker stop api db # detener ejecución de contenedores
$ docker rm api db # eliminar los contenedores actuales
```

Por cierto, estos comandos son útiles y podríamos tenerlos en un archivo, pero de momento es suficiente que conozcas estos comandos.

Ahora en el archivo start_app crearemos un volumen para la base de datos justo antes de tener a los contenedores funcionando

```bash
...
docker network create red_comun

docker volume create mongo_data

docker run -d --name api --netw ...
...
```

Ahora revisaremos la documentación de la [imagen de mongo](https://hub.docker.com/_/mongo) y nos fijaremos en la sección "Where to Store Data" y nos fijamos que tiene una línea que configura el contenedor con un volumen externo

```bash
$ docker run --name some-mongo -v /my/own/datadir:/data/db -d mongo
```
de donde podemos observar que los datos son guardados en "/data/db", podemos usar el volumen antes creado o usar un volumen externo, pero yo lo haré con el volumen interno así que nuestra línea del contenedor de mongo quedará así

```bash
## docker run -d --name db --network red_comun mongo:4.0.3
docker run -d --name db --network red_comun -v mongo_data:/data/db mongo:4.0.3
```

si ya habías iniciado antes este script deberás borrar los contenedores, los volúmenes y las redes

```bash
$ docker stop api db
$ docker rm api db
$ docker volume rm mongo_data
$ docker network rm red_comun
```

por último

```bash
$ sh start_app.sh
```

ahora nuestra aplicación está corriendo por el puerto 8000 y las rutas que usaremos para visualizar su funcionamiento son

- /profile/new
- /profiles

entraremos a [localhost:8000/profiles](http://localhost:8000/profiles) y veremos que no hay respuesta (lo correcto es que nod iera un array vacío), esto se debe a que en el bash inicia primero el contenedor de la api y después el de la base de datos, lo arreglaremos simplemente reiniciando el contenedor de la api.

```bash
$ docker restart api
```

y ahora si responderá adecuadamente con ([] array vacío), esto lo podemos probar con cualquier navegador o usando "curl"

```bash
$ curl http://localhost:8000/profiles
```

ahora usaremos también curl (o postman) para ingresar un registro

```bash
$ curl -d '{"nombre":"haku", "titulo":"dios sin nombre", "descripcion":"aparece en el viaje de chihiro"}' -H "Content-Type: application/json" -X POST http://localhost:8000/profile/new
```

volveremos a usar [localhost:8000/profiles](http://localhost:8000/profiles) y veremos nuestro registro finalmente.