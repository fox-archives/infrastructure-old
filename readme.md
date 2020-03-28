# infrastructure

my iac. contains personal configuration and some for a closed ias

## usage

if you wish to setup this system for yourself

supported platforms

- ubuntu 18.04

### prerequisites

use `scripts/install.sh` to install the following dependencies

- lxd
- distrobuilder
- docker
- docker-compose
- make
- terraform
- terraform-provider-lxd
- ansible

the following exist, but are not defined as code. you may need to manually set them up or change the code to make this project work

- network bridge at br0

## installation

```sh
git clone https://github.com/eankeen/corsac
cd corsac
./scripts/install.sh
make bootstrap
make start
```

## overview

### foundation

`foundation` is the master node, from which all other nodes are orchestrated from

### base

`base` contains code to provision at bare metal
