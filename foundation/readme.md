# foundation

`foundation` is the master node, from which all other nodes are orchestrated from. `packer` is responsible for building the server image. `ansible-remote` is responsible for provisioning the machine. `foundation` has a static ip of `10.0.0.2`. it spawns two lxd machine containers (chosen over vms due to vtax)

1. integrated kea dhcp4, kea dhcp ddns, and bind9 dns servers
2. terraform, ansible, and distrobuilder, and a clone of this repository
3. misc

## packer

`foundation` is an ubuntu 18.04 server. the image is build with packer, which is configured to use the qemu builder and `ansible-local` provisioner. notably, it configures the network and sshd; further setup is done during `ansible-remote`. you need to `dd` the resulting iso to your machine

in addition to root, it creates an `ops` user, with passwords `root-password` and `user-password`, respectively. the image configured to only allow non-root login, authenticated only with public keys. These temporary passwords can optionally be changed during remote provisioning

## ansible-remote

remotely provisions `foundation`. this mainly reconfigures the network (creates a bridged network device), recreates passwords for `root` and `user`, and creates some lxd machine containers. i created the `rotate-screen.service` because i use a monitor that's rotated 90 degrees for troubleshooting when the network is down.

## usage

note that setting the `rootPassword` and/or `opsPassword` variables are not strictly required

```sh
make bootstrap
make foundation-build
# now, dd the image in `packer/artifacts` to the metal
# on the tty, or from ssh's pty, resize partitions and vgs/lvs
rootPassword="$(openssl passwd -1)" opsPassword="$(openssl passwd -1)" make foundation-provision
```
