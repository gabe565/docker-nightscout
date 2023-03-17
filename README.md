# Nightscout Containers

This repo builds container images for [Nightscout](https://github.com/nightscout/cgm-remote-monitor).

Release tags are automatically updated by Renovate bot, so new Nightscout releases will be available in this repository within a few hours.

## Images

- [ghcr.io/gabe565/nightscout](https://github.com/gabe565/docker-nightscout/pkgs/container/nightscout)

## Deployment

### Docker

For Docker, I'd suggest using the [`docker-compose.yml`](./docker-compose.yml) in this repository.

### Kubernetes

I'm currently using the [k8s-at-home/nightscout](https://github.com/k8s-at-home/charts/tree/master/charts/stable/nightscout) Helm chart. k8s-at-home has deprecated their charts repository, so I will release my own chart and update this documentation soon.
