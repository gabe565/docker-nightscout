# Nightscout Containers

<!--renovate repo=nightscout/cgm-remote-monitor -->
[![Version](https://img.shields.io/badge/Version-v15.0.2-informational?style=flat)](https://github.com/gabe565/docker-nightscout/pkgs/container/nightscout)
[![Build](https://github.com/gabe565/docker-nightscout/actions/workflows/build.yml/badge.svg)](https://github.com/gabe565/docker-nightscout/actions/workflows/build.yml)

This repo builds container images for [Nightscout](https://github.com/nightscout/cgm-remote-monitor).

Release tags are automatically updated by Renovate bot, so new Nightscout releases will be available in this repository within a few hours.

## Images

- [ghcr.io/gabe565/nightscout](https://github.com/gabe565/docker-nightscout/pkgs/container/nightscout)

## Deployment

### Docker

For Docker, I'd suggest copying the [`compose.yaml`](./compose.yaml) in this repository, then adding any environment variables you desire from [Nightscout's documentation](https://github.com/nightscout/cgm-remote-monitor#environment).

### Kubernetes

I have built a Helm chart for Kubernetes deployments. See [charts.gabe565.com](https://charts.gabe565.com/charts/nightscout/) or [gabe565/charts](https://github.com/gabe565/charts/tree/main/charts/nightscout) for details.
