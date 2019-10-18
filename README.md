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

la aplicación api tiene algunas variables de entorno, todas con un valor por default en el código de el api

```node
// archivo src/node_api_test/server.js
...
  port = process.env.PORT || 3000,
...
  process.env.MONGO || 'mongodb://localhost:27017/Profile',
```

o sin valor por default

```node
//archivo src/node_api_test/otherUrls/uploadImages.js
...
    {storage: ImgurStorage({ 'clientId': process.env.IMGUR_CLIENT_ID})}
...
```

mirando detenidamente hay dos variables interesantes MONGO que al estar vacía el valor default es mongodb://localhost:27017/Profile, lo cual al tratar de conectarse dará un error

vamos a modificar la línea de el contenedor de la aplicación agregando la flag "-e" (environment) para agregar la cadena de conexión y el puerto de respuesta de la aplicación (no me gusta el 3000) y la variable IMGUR_CLIENT_ID no se definirá porque no es necesaria para este ejemplo.

```bash
# hay que notar que la cadena de conexión de mongo se usa el nombre "db" que es el nombre
# del contenedor de mongo (recuerda ponerlo porque docker los nombra por default con un nombre aleatorio)
## docker run -d --name api --network red_comun node_app_api
docker run -d --name api --network red_comun -e "MONGO=mongodb://db:27017/Profile" -e "PORT=8000" node_app_api
```
