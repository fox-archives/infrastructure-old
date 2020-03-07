# foundation

`foundation` manages the master node, from which all other nodes are orchestrated from

## ansible-local

## ansible-remote

to change the password of the machine, do something like this

```sh
opsPassword=$(openssl passwd -1) make foundation-provision
```

steps

1. `make foundation-build`
uses packer to build an ubuntu 18.04 image. it is configured to use the qemu builder with the shell and `ansible-local` provisioners. you need to manually `dd` the resulting iso to your machine

2. `make foundation-provision`
when the `foundation` machine is booted (with a static ip of `10.0.0.2`), we use `ansible-remote` to remotely provision it. this setups a bridged network device for some lxd containers, and updates passwords. the first machine container contains integrated kea dhcp4, kea dhcp ddns, and bind9 dns servers. anything else is provisioned in the second lxd container, such as terraform, ansible, and distrobuilder.
