#!/usr/bin/env bash
set -e
docker run -e "RANCHER_VM=true" \
           --cap-add NET_ADMIN \
           -d \
           --name ubuntu_vm \
           -v /var/lib/rancher/vm:/vm \
           --device /dev/kvm:/dev/kvm \
           --device /dev/net/tun:/dev/net/tun \
           artbio/ubuntu-vm -m 2048m
