#!/usr/bin/env bash
# We enter the script directory
cd "${0%/*}"
# We start the image, copy the the default base image (which is fixed at 2GB in size)
docker run -d --name rancher rancher/vm-ubuntu
docker cp rancher:/base_image/ubuntu-14.04-amd64.img ubuntu-14.04-amd64.img
cp ubuntu-14.04-amd64.img new.qcow2
qemu-img resize new.qcow2 +5GB
sudo virt-resize --expand /dev/vda1 ubuntu-14.04-amd64.img new.qcow2
# now we've got a resized partition, so we can build a new docker image
docker build -t artbio/ubuntu-vm .
