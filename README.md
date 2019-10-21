# proyecto de ejemplo para levantar docker

Este proyecto muestra como levantar docker a nivel comando para reemplazarlos con un docker-compose.yml

Advertencia, necesitas navegar en el log de git para ver los cambios y el por que de tales cambios

## requerimientos

- aplicación de node que requiera de mongo (aquí una hecha)[repo](https://github.com/siht/node_api_test)
- según el [repo](https://github.com/siht/node_api_test), necesitamos:
    - node: 10.16.3
    - mongo: 4.0.3

## instrucciones

por el momento ese .env está bien, pero procuraremos usarlo sólo para cosas relacionadas a configuración de docker, para las aplicaciones colocaremos su propio archivo ".env"

modificaremos el gitignore para que no lea cualquier archivo que comience por 

```gitignore
.env*

```

y el archivo ".env" lo renombraremos a ".env_api" y al archivo docker-compose.yml en la parte de environment lo remplazaremos

```yaml
    # environment:
    #   MONGO: ${MONGO}
    #   IMGUR_CLIENT_ID: ${IMGUR_CLIENT_ID}
    #   PORT: ${PORT}
    env_file: .env_api
```

a veces tendremos problemas al iniciar la aplicación api, pero si esto sucede, sólo hay que reiniciar la aplicación, lo más seguro es que la base de datos aun no esté correctamente inicializada y no pueda conectarse otra vez

Este comando hará la magia

```bash
$ docker-compose restart 
```