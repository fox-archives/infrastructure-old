# foundation

`foundation` is the master node, from which all other nodes are orchestrated from, at least indirectly. `packer` is responsible for building the server image. `ansible-remote` is responsible for provisioning the machine. `foundation` has a static ip of `10.0.0.2`. it spawns two lxd machine containers (to spare vtax). the machine provisioning `foundation` requires packer, ansible, and distrobuilder

1. kea dhcp4, kea ddns, and bind9 dns server
2. terraform, ansible, and distrobuilder, and a git clone of this repository

## packer

`foundation` is an ubuntu 18.04 server. the image is build with packer, which is configured to use the qemu builder and `ansible-local` provisioner. notably, it configures the network and sshd; further setup is done during `ansible-remote`. you need to `dd` the resulting iso to your machine

in addition to root, it creates an `ops` user, with passwords `root-password` and `user-password`, respectively. the image configured to only allow non-root login, authenticated only with public keys. These temporary passwords can optionally be changed during remote provisioning

## ansible-remote

remotely provisions `foundation`. this prepares system for `lxd` and creates a network interface bridge. i created the `rotate-screen.service` because i use a monitor that's rotated 90 degrees for troubleshooting when the network is down. to do this, `foundation` needs to be accessible at `10.0.0.2` using `foundation.key`

## distrobuilder

builds images for use on

## usage

note that setting the `rootPassword` and/or `opsPassword` variables are not strictly required

```sh
make bootstrap
make foundation-build
# now, dd the image in `packer/artifacts` to the metal
# on the tty, or from ssh's pty, resize partitions and vgs/lvs
rootPassword="$(openssl passwd -1)" opsPassword="$(openssl passwd -1)" make foundation-provision
```
