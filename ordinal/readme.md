# ordinal

contains code for the ordinal lxd containers provisioned on `foundation`
. the lxd machine containers are called `foundation-{primary,secondary,tertiary}`, to provide the following functionality:

1. `primary` contains the kea dhcp4, kea ddns, and bind9 dns server
2. `secondary` contains terraform, ansible, and distrobuilder, and a git clone of this repository
3. `tertiary` is yet to be used

## distrobuilder

- lxd container images build with distrobuilder (code in `distrobuilder`)
  - custom templates for `/etc/hostname` and `/etc/hosts` to ensure correct hostname is broadcasted during initial dhcp discovery phrase (`cloud-init` stage is too late for lxd containers)
  - installs packages (at build time)

## ansible

- sets up bind9 and kea servers on `primary`
- installs all required tools on `secondary`
- general configuration for all hosts

```sh
# first: generate keys for each guest container
make generate-keys

# second: create artifacts required to start the `lxd` containers
make distrobuilder-generate-and-package

# third: further provision machine to final state
playbook=primary make ansible-provision
```
