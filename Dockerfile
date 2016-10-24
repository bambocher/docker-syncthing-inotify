FROM alpine:3.4
MAINTAINER Dmitry Prazdnichnov <dp@bambucha.org>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/bambocher/docker-syncthing-inotify" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

ENV URL=github.com/syncthing/syncthing-inotify \
    GOPATH=/ \
    XDG_CONFIG_HOME=/ \
    BUILD="curl jq go godep git"

RUN apk --no-cache add ca-certificates $BUILD && \
    git clone -b $VERSION https://$URL /src/$URL && \
    cd /src/$URL && \
    godep get && \
    rm -rf /src /pkg && \
    apk del $BUILD

COPY entrypoint.sh /entrypoint.sh

USER 1000:1000
VOLUME ["/syncthing", "/mnt"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-target=http://syncthing:8384", "-logflags=0"]
