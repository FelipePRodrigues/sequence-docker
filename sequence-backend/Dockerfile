FROM ubuntu:18.04

LABEL Felipe Rodrigues <felipeprodrigues@outlook.com.br>

RUN apt-get update && apt-get install -y wget

RUN apt-get install -y aria2 && \
    wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast -O /usr/local/sbin/apt-fast && \
    chmod +x /usr/local/sbin/apt-fast && \
    wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast.conf -O /etc/apt-fast.conf

RUN apt-fast install -y \
    software-properties-common \
    postgresql-client \
    git \
    python3-pip \
    python3-dev \
    nginx

############## INSTALL LANGUAGE ##############

RUN apt-fast install -y language-pack-id

############## CONFIGURE NGINX ##############

RUN ln -sf /dev/stdout /var/log/nginx/access.log

RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

############## CONFIGURE LANGUAGE ##############

RUN locale-gen pt_BR.UTF-8

RUN export LC_NUMERIC="pt_BR.UTF-8"

############## INSTALL SEQUENCE - BACKEND ##############

WORKDIR /var/www

RUN git clone https://github.com/FelipePRodrigues/sequence-backend.git

WORKDIR /var/www/sequence-backend

RUN pip3 install --upgrade pip

RUN pip3 install -r requirements.txt

############## INITIALIZE CONTAINER ##############

EXPOSE 80

COPY gunicorn.sh gunicorn.sh
COPY docker-entrypoint.sh docker-entrypoint.sh

ENTRYPOINT ["/bin/bash", "docker-entrypoint.sh"]
