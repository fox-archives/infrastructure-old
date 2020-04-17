# foundation

`foundation` runs important network-critical programs (dns, dhcp) and provides and environment to bootstrap configuration on other computers. this pysical machine runs debian 10 (buster) and creates lxd machine containers called `foundation-container-{first,second,third}`, to provide functionality:

1. `first` contains the kea dhcp4, kea ddns, and bind9 dns server
2. `second` contains terraform, ansible, and distrobuilder, and a git clone of this repository
3. `third` is yet to be used

## packer

- the image is build with packer, and must be `dd`'ed to the metal manually
- packer uses the qemu builder (code in `packer/debian.json`), which eventually starts the ansible-local provisioner (code in `packer/ansible-local`)
- the ansible-local provisioner:
  - sets up network partially and sshd
  - creates users and their passwords

## ansible-remote

- further config is done with ansible remotely (code in `ansible-remote`)
- it finishes network config (creates bridged network device)
- does other miscellaneous configuration
- starts the three lxd containers

## distrobuilder

- lxd container images build with distrobuilder (code in `distrobuilder`)

## usage

note that setting the `rootPassword` and/or `opsPassword` variables are not strictly required

```sh
# bootstrap
make bootstrap

# first: generate ssh keys for host machine
make generate-host-key

# second: build images with packer
make packer-build
# now, dd the image in `packer/artifacts` to the metal
# on the tty, or from ssh's pty, resize partitions and vgs/lvs

# third: create artifacts required for remote ansible provisioning
make distrobuilder-bootstrap
make distrobuilder-package

# fourth: generate keys for each guest container
make generate-guest-keys

# fifth: remotely provision host machine
# TODO: rootPassword and opsPassword have no effect and should later not be passed at all
rootPassword="$(openssl passwd -1)" opsPassword="$(openssl passwd -1)" make ansible-remote-provision
```
