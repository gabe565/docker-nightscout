FROM node:8-alpine

WORKDIR /app

RUN set -x \
    && apk add --no-cache git \
    && git clone https://github.com/nightscout/cgm-remote-monitor.git . \
    && npm install \
    && npm run postinstall \
    && apk del git

EXPOSE 1337

CMD ["node", "server.js"]
