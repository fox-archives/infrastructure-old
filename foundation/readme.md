# foundation

`foundation` runs important network-critical programs (dns, dhcp) and provides and environment to bootstrap configuration on other computers. this physical machine runs debian 10 (buster) and creates three lxd containers to accomplish this; details of containers can be found in `/ordinal`

## packer

- the image is build with packer, and must be `dd`'ed manually
- packer is configured to use the qemu builder (code in `packer/debian.json`), which eventually starts the ansible-local provisioner (code in `packer/ansible-local`)
- the ansible-local provisioner:
  - sets up network partially and sshd
  - creates users and their passwords

## ansible-remote

- further config is done with ansible remotely (code in `ansible-remote`)
- it finishes network config (creates bridged network device)
- does other miscellaneous configuration
- starts the three lxd containers

## usage

note that setting the `rootPassword` and/or `opsPassword` variables are not strictly required. TODO: void this option

```sh
# first: generate ssh keys for host machine
make generate-key

# second: build images with packer
# dd result (`packer/artifacts/*.iso`) to disk
make packer-build

# third: remotely provision host machine
# note: requires multiple password entries
rootPassword="$(openssl passwd -1)" opsPassword="$(openssl passwd -1)" make ansible-remote-provision
```
