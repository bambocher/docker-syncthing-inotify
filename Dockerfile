FROM alpine:3.4
MAINTAINER Dmitry Prazdnichnov <dp@bambucha.org>

ENV URL=github.com/syncthing/syncthing-inotify \
    API=https://api.github.com/repos/syncthing/syncthing-inotify/releases/latest \
    GOPATH=/ \
    XDG_CONFIG_HOME=/ \
    BUILD="curl jq go godep git"

RUN apk --no-cache add ca-certificates $BUILD && \
    VERSION=`curl -s $API | jq -r '.tag_name'` && \
    git clone -b $VERSION https://$URL /src/$URL && \
    cd /src/$URL && \
    godep get && \
    rm -rf /src /pkg && \
    apk del $BUILD

COPY entrypoint.sh /entrypoint.sh

USER 1000:1000
VOLUME /syncthing /mnt

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-target=http://syncthing:8384", "-logflags=0"]
