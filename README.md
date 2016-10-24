# Alpine Syncthing Inotify Docker Container

[![Version](https://images.microbadger.com/badges/version/bambucha/syncthing-inotify.svg)](https://microbadger.com/images/bambucha/syncthing-inotify) [![Layers](https://images.microbadger.com/badges/image/bambucha/syncthing-inotify.svg)](https://microbadger.com/images/bambucha/syncthing-inotify/) [![](https://images.microbadger.com/badges/commit/bambucha/syncthing-inotify.svg)](https://microbadger.com/images/bambucha/syncthing-inotify) [![Docker Stars](https://img.shields.io/docker/stars/bambucha/syncthing-inotify.svg)](https://registry.hub.docker.com/u/bambucha/syncthing-inotify/) [![Docker Pulls](https://img.shields.io/docker/pulls/bambucha/syncthing-inotify.svg)](https://registry.hub.docker.com/u/bambucha/syncthing-inotify/) [![Docker Automated Build](https://img.shields.io/badge/automated-build-green.svg)](https://registry.hub.docker.com/u/bambucha/syncthing-inotify/) [![Docker License](https://img.shields.io/badge/license-MIT-green.svg)](https://registry.hub.docker.com/u/bambucha/syncthing-inotify/)

## Usage

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

## License

[The MIT License](LICENSE)
