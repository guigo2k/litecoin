
# Litecoin K3s Pool

[![build](https://github.com/guigo2k/litecoin/actions/workflows/build.yml/badge.svg)](https://github.com/guigo2k/litecoin/actions/workflows/build.yml)
[![release](https://github.com/guigo2k/litecoin/actions/workflows/release.yml/badge.svg)](https://github.com/guigo2k/litecoin/actions/workflows/release.yml)
[![deploy](https://github.com/guigo2k/litecoin/actions/workflows/deploy.yml/badge.svg)](https://github.com/guigo2k/litecoin/actions/workflows/deploy.yml)

## Table of Contents
- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Limitations](#limitations)
- [Getting Started](#getting-started)
- [Cleaning Up](#cleaning-up)

## Overview
This is a proof-of-concept for deploying a [Litecoin](https://github.com/litecoin-project/litecoin) pool on highly available [K3s](https://k3s.io/) clusters. This repository includes Docker image, Helm chart and Terraform module. The module uses [Flatcar Container Linux](https://kinvolk.io/flatcar-container-linux/) as instances AMI.

`WARNING:` The `k3s` module is NOT production ready!

## Limitations
Many things are outside the scope of this POC, most notably:
* TLS termination
* Ingress routes
* Autoscaling
* Monitoring

## Getting Started
Make sure your AWS credentials are exported.
```sh
$ export AWS_ACCESS_KEY_ID=xxx
$ export AWS_SECRET_ACCESS_KEY=xxx
```

A single replica `statefulset` is automatically deployed when the cluster is created.
```sh
$ make cluster
```

After a few minutes, you can get the `kubeconfig` file.
```sh
$ make kubeconfig
```

Check if everything is working fine:
```
$ kubectl get pods
NAME                          READY   STATUS      RESTARTS   AGE
helm-install-litecoin-qq9lx   0/1     Completed   1          2m1s
litecoin-0                    1/1     Running     0          56s
```

## Cleaning Up
To clean up, simply run:
```
$ make clean
```

Have fun! :blush:
