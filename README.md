# proyecto de ejemplo para levantar docker

Este proyecto muestra como levantar docker a nivel comando para reemplazarlos con un docker-compose.yml

Advertencia, necesitas navegar en el log de git para ver los cambios y el por que de tales cambios

## requerimientos

- aplicación de node que requiera de mongo (aquí una hecha)[repo](https://github.com/siht/node_api_test)
- según el [repo](https://github.com/siht/node_api_test), necesitamos:
    - node: 10.16.3
    - mongo: 4.0.3

## instrucciones

Si bien node puede no necesitar de un servidor al poder implementar redirecciones, implementación de conexiones seguras, normlamente a node lo colocaremos detrás de un servidor apache o nginx

Agregaremos un apache a manera de reverse proxy, para esto podríamos hacer nuetra propia receta, sin embargo en dockerhub es muy posible que alguien haya hecho un reverse proxy

Y vemos en dockerhub [diouxx/apache-proxy](https://hub.docker.com/r/diouxx/apache-proxy) alguien ya resolvió una receta, la aplicaremos

en el docker-compose.yml agregaremos al final de los servicios

```yaml
  reverse_proxy:
    image: diouxx/apache-proxy
    ports:
      - 80:80
    volumes:
      - ./conf/dev_sites.conf:/opt/proxy-conf/sites.conf
```

y removeremos el puerto de salida de la aplicación por si sola quedando el archivo de esta manera

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
    env_file: .env_api
  reverse_proxy:
    image: diouxx/apache-proxy
    ports:
      - 80:80
    volumes:
      - ./conf/dev_sites.conf:/opt/proxy-conf/sites.conf

volumes:
  mongo_data:
```

agregaremos un archivo de configuración llamado dev_sites.conf dentro de una nueva carpeta llamada conf

```conf
# conf/dev_sites.conf
<VirtualHost *:80>
    ServerAdmin yo.mero@gmail.com
    ServerName mi.sitio.com
    ServerAlias www.mi.sitio.com
    ProxyRequests off
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>
    <Location />
        ProxyPass http://api:8000/
        ProxyPassReverse http://api:8000/
    </Location>
</VirtualHost>
```

y para hacer la prueba de que ya tenemos nuestro sitio [mi.sitio.com](mi.sitio.com), moodificaremos en nuestro local un archivo llamado hosts

el caso linux/mac se encuentra en /etc/hosts, añadiremos al final del archivo

```text
127.0.0.1   mi.sitio.com    www.mi.sitio.com
```

y procedemos a entrar a la dirección [mi.sitio.com](mi.sitio.com)

Si esto queremos que esté en un servidor, hay que recordar que debes comprar un DNS y conseguir hosting para tu sitio.