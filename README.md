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

como acabas de ver es sólo para levantar 2 contenedores ya es una carga visiblemente grande, a pesar de que se automatiza el proceso, tal vez un script bash no es la mejor solución, hay herramientas dedicadas a este tipo de tareas como make. Sin embargo, se ha creado una herramienta que tiene todos estos atajos ya creados: docker-compose

vamos a reemplazar nuestro amado bash en un archivo docker-compose.yml, empezaremos por la versión que queremos usar de nuestro docker-compose (la versión 3 estará bien).
Definir lo que necesitamos, services (o instancias de imágenes, contenedores para los cuates) que involucran una base de datos que llamaremos db y una aplicacion que llamaremos api, volumes (volúmenes) en este caso uno para la base de datos, en este caso no definiremos una network ya que el docker-compose define una por default que se llama "default" y todos los contenedores dentro del docker-compose están dentro de esa red

```yml
version: '3'

services:
  db:
  api:

volumes:
  mongo_data:
```

para este punto aun no podemos correr el docker compose porque falta definir exactamente los servicios, mientras que los volumenes y las redes a están configuradas, esto se hará en el siguiente paso.