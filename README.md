# Nginx proxy

> Fork from evertramos's [docker-compose-letsencrypt-nginx-proxy-companion](https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion) and using multiple network

## Usage

Start with .env.default
```shell
sh scripts/start.sh --default
```

Or using your own .env
```shell
cp .env.default .env

# modify .env ...

sh scripts/start.sh
```
