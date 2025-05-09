#syntax=docker/dockerfile:1

ARG NIGHTSCOUT_REPO=nightscout/cgm-remote-monitor
ARG NIGHTSCOUT_REF=15.0.3
ARG FLAVOR=base

FROM --platform=$BUILDPLATFORM node:22-alpine AS nightscout-base
WORKDIR /app

RUN apk add --no-cache g++ git make python3

ARG NIGHTSCOUT_REPO
ARG NIGHTSCOUT_REF
RUN <<EOT
  set -eux
  git clone -q \
    --config advice.detachedHead=false \
    --branch "$NIGHTSCOUT_REF" \
    --depth 1 \
     "https://github.com/$NIGHTSCOUT_REPO.git" .
  rm -rf .git

  mkdir -p tmp
  chown -R node:node tmp
EOT

FROM --platform=$BUILDPLATFORM nightscout-base AS nightscout-websocket
RUN sed -i 's/\["polling"]/["websocket", "polling"]/' lib/client/index.js

FROM --platform=$BUILDPLATFORM nightscout-$FLAVOR AS nightscout
RUN npm ci

FROM node:22-alpine
LABEL org.opencontainers.image.source="https://github.com/gabe565/docker-nightscout"
WORKDIR /app

RUN apk add --no-cache tini

COPY --from=nightscout /app /app

EXPOSE 1337

# Nightscout binds to HOSTNAME, have to bind to 0.0.0.0 instead of an IP address
ENV HOSTNAME=::

USER node

CMD ["tini", "--", "node", "lib/server/server.js"]
