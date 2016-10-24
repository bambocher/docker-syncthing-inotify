# Syncthing Inotify Docker Image

[![Version](https://images.microbadger.com/badges/version/bambucha/syncthing-inotify.svg)](https://microbadger.com/images/bambucha/syncthing-inotify) [![Layers](https://images.microbadger.com/badges/image/bambucha/syncthing-inotify.svg)](https://microbadger.com/images/bambucha/syncthing-inotify/) [![Commit](https://images.microbadger.com/badges/commit/bambucha/syncthing-inotify.svg)](https://microbadger.com/images/bambucha/syncthing-inotify) [![License](https://images.microbadger.com/badges/license/bambucha/syncthing-inotify.svg)](https://microbadger.com/images/bambucha/syncthing-inotify) [![Automated Build](https://img.shields.io/docker/automated/bambucha/syncthing-inotify.svg)](https://registry.hub.docker.com/u/bambucha/syncthing-inotify/) [![Docker Pulls](https://img.shields.io/docker/pulls/bambucha/syncthing-inotify.svg)](https://registry.hub.docker.com/u/bambucha/syncthing-inotify/)

[Syncthing](https://github.com/syncthing/syncthing/) [Inotify](https://github.com/syncthing/syncthing-inotify/) [Docker](https://docker.com/) image based on [Alpine](https://alpinelinux.org/) Linux.

## [Docker Compose](https://docs.docker.com/compose/)

```shell
SYNC_USER=1000
SYNC_GROUP=1000
SYNC_CONF=$(pwd)/config
SYNC_DATA=$(pwd)/data
sudo mkdir $SYNC_DATA $SYNC_CONF
sudo chown $SYNC_USER:$SYNC_GROUP $SYNC_DATA $SYNC_CONF
```

```shell
vi docker-compose.yml
```

```yml
version: "2"
services:
  syncthing:
    restart: always
    image: bambucha/syncthing
    user: 1000:1000
    volumes:
      - ./config:/syncthing
      - ./data:/mnt
    ports:
      - 8384:8384
      - 22000:22000
      - 21027:21027/udp
  inotify:
    restart: always
    image: bambucha/syncthing-inotify
    user: 1000:1000
    volumes:
      - ./config:/syncthing:ro
      - ./data:/mnt:ro
    links:
      - syncthing
```

```shell
docker-compose up -d
```

## License

[The MIT License](LICENSE)
