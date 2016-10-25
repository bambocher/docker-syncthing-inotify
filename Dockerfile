FROM alpine:3.4
MAINTAINER Dmitry Prazdnichnov <dp@bambucha.org>

ARG VCS_REF
ARG VERSION

ENV URL=github.com/syncthing/syncthing-inotify \
    GOPATH=/ \
    XDG_CONFIG_HOME=/ \
    BUILD="go godep git" \
    VCS_URL=https://github.com/bambocher/docker-syncthing-inotify

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.version=$VERSION \
      org.label-schema.license=MIT \
      org.label-schema.schema-version="1.0"

RUN apk --no-cache add ca-certificates curl $BUILD && \
    git clone -b v$VERSION https://$URL /src/$URL && \
    cd /src/$URL && \
    godep get && \
    rm -rf /src /pkg && \
    apk del $BUILD

COPY ./entrypoint.sh /

USER 1000:1000
VOLUME ["/syncthing", "/mnt"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-target=http://syncthing:8384", "-logflags=0"]
