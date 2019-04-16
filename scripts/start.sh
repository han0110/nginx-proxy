#!/bin/bash

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -o|--os)
    OS="$2"
    shift # past argument
    shift # past value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument
    ;;
esac
done

# 1. Check if .env file exists
ENVPATH="./.env"
ENVPATH_DEFAULT="./.env.default"

if [ "${DEFAULT}" = "YES" ]; then
    if [ -e "${ENVPATH}" ]; then
        read -p "File .env exist, are you sure copy .env.default into .env (y/n)? " yn
        case $yn in
            [Yy]* ) ;;
            * ) echo "Abort"; exit 1;;
        esac
    fi
    cp "${ENVPATH_DEFAULT}" "${ENVPATH}"
fi

if [ -e "${ENVPATH}" ]; then
    source "${ENVPATH}"
else
    echo "Please set up your "${ENVPATH}" file before starting your environment."
    exit 1
fi

# 2. Setup different os requirement
if [ "$OS" = "GCP" ]; then
    source ./scripts/docker-compose-alias.sh
fi

# 3. Create docker network
docker network create $NETWORK $NETWORK_OPTIONS
docker network create $SERVICE_NETWORK $SERVICE_NETWORK_OPTIONS

# 4. Download the latest version of nginx.tmpl
curl https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl > nginx.tmpl

# 5. Update local images
docker-compose pull

# 6. Start proxy
docker-compose up -d

exit 0
