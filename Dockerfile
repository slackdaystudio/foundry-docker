FROM ubuntu:20.04

LABEL maintainer="phil.guinchard@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive
ARG HOSTNAME
ARG FOUNDRY_VERSION

ENV ENV_HOSTNAME=${HOSTNAME}
ENV ENV_FOUNDRY_VERSION=${FOUNDRY_VERSION}

RUN apt -y update && \
    apt install -y curl && \
    adduser --gecos "" --disabled-password --home /home/foundry foundry && \
    usermod -aG sudo foundry && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt install -y debian-keyring debian-archive-keyring apt-transport-https nodejs unzip nano nginx certbot

EXPOSE 80 443

ADD ./files/foundryvtt-${FOUNDRY_VERSION}.zip ./files/init.sh ./files/app.conf ./files/options.json /opt/

CMD [ "/bin/sh", "/opt/init.sh" ]