# proyecto de ejemplo para levantar docker

Este proyecto muestra como levantar docker a nivel comando para reemplazarlos con un docker-compose.yml

Advertencia, necesitas navegar en el log de git para ver los cambios y el por que de tales cambios

## requerimientos

- aplicación de node que requiera de mongo (aquí una hecha)[repo](https://github.com/siht/node_api_test)
- según el [repo](https://github.com/siht/node_api_test), necesitamos:
    - node: 10.16.3
    - mongo: 4.0.3

## instrucciones

el docker-compose está hecho de forma que puedes sobre escribir instrucciones y agregar configuraciones, bueno, si bien es cierto que así funciona, necesitamos agregar algunas directivas más.

para empezar node tiene entre sus miles de aplicaciones una aplicación llamada [pm2](http://pm2.keymetrics.io/), que es un administrador de procesos, desde aquí tu puedes dar directivas para que pasa cuando se cae un proceso. Bueno, en docker también es posible, pero no lo haremos en el mismo archivo porque queremos una base para poder hacer un entorno de desarrollo y uno de producción, comenzaremos por el de producción.

Generaremos un archivo nuevo llamado docker-compose.prod.yml, en el cual volveremos a colocar todo lo que queremos sobre escribir, en este caso sólo lo haremos con los servicios y colocaremos la directiva restart con el valor always. Esto permitirá que si por alguna razón se caen los contenedores, se intente siempre levantar un nuevo contenedor

```yaml
version: '3'

services:
  db:
    restart: always
  api:
    restart: always
  reverse_proxy:
    restart: always
```