ARG NODE_VERSION=14

FROM --platform=$BUILDPLATFORM node:$NODE_VERSION-alpine as builder

ARG NIGHTSCOUT_REPO_PATH=nightscout/cgm-remote-monitor

ARG NIGHTSCOUT_RELEASE
ENV NIGHTSCOUT_RELEASE=$NIGHTSCOUT_RELEASE

WORKDIR /app

RUN apk add --no-cache \
        g++ \
        git \
        make \
        python3

RUN set -x \
    && git clone -q \
        --config advice.detachedHead=false \
        --branch "$NIGHTSCOUT_RELEASE" \
        --depth 1 \
         "https://github.com/$NIGHTSCOUT_REPO_PATH.git" . \
    && npm ci \
    && npm run postinstall

FROM node:$NODE_VERSION-alpine
LABEL org.opencontainers.image.source="https://github.com/gabe565/docker-nightscout"

COPY --from=builder /app /app

EXPOSE 1337

# Nightscout binds to HOSTNAME, have to bind to 0.0.0.0 instead of an IP address
ENV HOSTNAME ::

CMD ["node", "server.js"]
