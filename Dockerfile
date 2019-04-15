FROM node:8-alpine

ARG NIGHTSCOUT_REPO_PATH=nightscout/cgm-remote-monitor
ARG NIGHTSCOUT_VERSION=0.11.1

WORKDIR /app

RUN set -x \
    && apk add --no-cache tar \
    && wget -q -O release.tar.gz "https://github.com/${NIGHTSCOUT_REPO_PATH}/archive/${NIGHTSCOUT_VERSION}.tar.gz" \
    && tar -xzf release.tar.gz --strip-components=1 \
    && rm -rf .git \
    && npm install \
    && npm run postinstall \
    && apk del tar

EXPOSE 1337

# Nightscout binds to HOSTNAME, have to bind to 0.0.0.0 instead of an IP address
ENV HOSTNAME 0.0.0.0

CMD ["node", "server.js"]
