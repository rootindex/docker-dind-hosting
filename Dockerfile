FROM docker:stable-dind

LABEL maintainer="Francois Raubenheimer rootindex@gmail.com"

RUN set -xe \
    && apk add --no-cache python \
    && apk add --no-cache --virtual install-tools py-pip \
    && pip install docker-compose \
    && apk del install-tools

ADD rootfs /

EXPOSE 80

WORKDIR /srv

VOLUME ["/srv"]

HEALTHCHECK CMD /usr/local/bin/healthcheck.sh