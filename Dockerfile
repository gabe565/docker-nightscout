ARG NODE_VERSION=14
ARG NIGHTSCOUT_REPO=nightscout/cgm-remote-monitor
ARG NIGHTSCOUT_REF=14.2.6

FROM --platform=$BUILDPLATFORM node:$NODE_VERSION-alpine as builder
WORKDIR /app

RUN apk add --no-cache \
        g++ \
        git \
        make \
        python3

ARG NIGHTSCOUT_REPO
ARG NIGHTSCOUT_REF
RUN set -x \
    && git clone -q \
        --config advice.detachedHead=false \
        --branch "$NIGHTSCOUT_REF" \
        --depth 1 \
         "https://github.com/$NIGHTSCOUT_REPO.git" . \
    && npm ci \
    && npm run postinstall

FROM node:$NODE_VERSION-alpine
LABEL org.opencontainers.image.source="https://github.com/gabe565/docker-nightscout"
WORKDIR /app

COPY --from=builder /app /app

EXPOSE 1337

# Nightscout binds to HOSTNAME, have to bind to 0.0.0.0 instead of an IP address
ENV HOSTNAME ::

CMD ["node", "server.js"]
