artbio/docker-ubuntu-vm
-----

This is a simple ubuntu vm running in a container.
To run, make sure docker and kvm are installed on the host.

```
docker run -e "RANCHER_VM=true" \ 
           --cap-add NET_ADMIN \
           -it \
           -v /var/lib/rancher/vm:/vm \
           --device /dev/kvm:/dev/kvm \
           --device /dev/net/tun:/dev/net/tun \
           artbio/ubuntu-vm -m 2048m
```

This will start a VM with 2048MB RAM.
You can ssh into the containers with username ubuntu and password ubuntu.


How to resize ubuntu image for rancher
------

The initial vm image is included in the rancher docker image (rancher/vm-ubuntu).
You need to have libguestfs-tools installed (apt-get install libguestfs-tools).

We start the image, copy the the default base image (which is fixed at 2GB in size)

```
docker run -d --name rancher rancher/vm-ubuntu
docker cp rancher:/base_image/ubuntu-14.04-amd64.img ubuntu-14.04-amd64.img
cp ubuntu-14.04-amd64.img new.qcow2 
qemu-img resize new.qcow2 +5GB
sudo virt-resize --expand /dev/vda1 ubuntu-14.04-amd64.img new.qcow2
```

now we've got a resized partition, so we can build a new docker image

```
docker build -t artbio/vm-ubuntu .
```
