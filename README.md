# Sequence - Docker
##### *version 1.0*

## Description
This project allows you to run the sequence API through docker-compose.

## Requirements
* Docker
* Docker Compose

## How to Deploy
First, clone the repository:
```shell
$ git clone https://github.com/FelipePRodrigues/sequence-docker.git
```

After, you need to build the projects images and run the apps:
```shell
$ docker-compose -f docker-compose.yml build
$ docker-compose -f docker-compose.yml up -d
```

Then you can access the api through [this link](http://localhost:8050/api/v1/).

## How to access the Django Admin interface
First, you need to create a django superuser:
```shell
$ sudo su
$ docker exec -it sequence-backend-container bash
$ python3 manage.py createsuperuser #choose your credencials
```
Then you can access the admin interface through [this link](http://localhost:8050/admin).
