FROM alpine:3.5
MAINTAINER Dmitry Prazdnichnov <dp@bambucha.org>

ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=https://github.com/bambocher/docker-syncthing-inotify \
      org.label-schema.license=MIT \
      org.label-schema.schema-version=1.0

ENV URL=https://github.com/syncthing/syncthing-inotify/releases/download \
    XDG_CONFIG_HOME=/ \
    HOME=/mnt

RUN apk --no-cache add ca-certificates \
    && apk --no-cache --virtual build-dependencies add curl tar \
    && curl -sL $URL/v$VERSION/syncthing-inotify-linux-amd64-v$VERSION.tar.gz \
        | tar xz --no-anchored -C /usr/bin --strip-components=1 syncthing-inotify \
    && apk del build-dependencies

COPY ./entrypoint.sh /

USER 1000:1000
VOLUME ["/syncthing", "/mnt"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-target=http://syncthing:8384", "-logflags=0"]
