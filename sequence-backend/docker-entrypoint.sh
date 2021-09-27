#!/usr/bin/bash

while ! pg_isready -h ${DB_HOST} -p ${DB_PORT} > /dev/null 2> /dev/null; do
  echo "Connecting to ${DB_HOST} Failed"
  sleep 1
done

echo "
DATABASES = {
   'default': {
       'ENGINE': '${DB_ENGINE}',
       'NAME': '${DB_NAME}',
       'USER': '${DB_USER}',
       'PASSWORD': '${DB_PASSWORD}',
       'HOST': '${DB_HOST}',
       'PORT': '${DB_PORT}'
   }
}

DEBUG =  ${DEBUG}

PRODUCTION =  ${PRODUCTION}

PORT = 80

ALLOWED_HOSTS = ['*']
" > sequence/local_settings.py

cat sequence/local_settings.py


echo "
server {
    listen 80 default_server;
    server_name localhost;

    client_max_body_size 100M;
    large_client_header_buffers 4 100M;
    server_tokens off;

    location / {
        proxy_cache_valid 5m;
        include proxy_params;
        proxy_pass http://unix:/var/www/sequence-backend/sequence.sock;
    }

    location /static/  {
        proxy_cache_valid 5m;
        alias /var/www/sequence-backend/static/;
    }

    location /media/  {
        proxy_cache_valid 5m;
        alias /var/www/sequence-backend/media/;
    }
}
" > /etc/nginx/sites-enabled/default

cat /etc/nginx/sites-enabled/default

python3 manage.py makemigrations
python3 manage.py migrate

python3 manage.py collectstatic --noinput

echo "Starting gunicorn..."

chmod +x gunicorn.sh && ./gunicorn.sh &

echo "Starting nginx..."

/etc/init.d/nginx start

echo "services initialized!"
