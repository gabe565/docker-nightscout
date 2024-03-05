#syntax=docker/dockerfile:1.7

ARG NIGHTSCOUT_REPO=nightscout/cgm-remote-monitor
ARG NIGHTSCOUT_REF=15.0.0

FROM --platform=$BUILDPLATFORM node:16-alpine as builder
WORKDIR /app

RUN apk add --no-cache \
        g++ \
        git \
        make \
        python3

ARG NIGHTSCOUT_REPO
ARG NIGHTSCOUT_REF
RUN <<EOT
  set -eux
  git clone -q \
    --config advice.detachedHead=false \
    --branch "$NIGHTSCOUT_REF" \
    --depth 1 \
     "https://github.com/$NIGHTSCOUT_REPO.git" .
  npm ci
  npm run postinstall
EOT

RUN mkdir -p tmp && chown -R node:node tmp

FROM node:16-alpine
LABEL org.opencontainers.image.source="https://github.com/gabe565/docker-nightscout"
WORKDIR /app

COPY --from=builder /app /app

EXPOSE 1337

# Nightscout binds to HOSTNAME, have to bind to 0.0.0.0 instead of an IP address
ENV HOSTNAME ::

USER node

CMD ["node", "server.js"]
