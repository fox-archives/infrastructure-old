# corsac

an iaas i'm setting up on my hardware to help my friends create 'production-grade', statefull public-facing services. or just playing around as root in an (optionally ephemeral) linux environment.

## usage

if you wish to setup this system for yourself

supported platforms

- ubuntu 18.04

### prerequisites

use `scripts/install.sh` to install the following dependencies

- lxd
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

### terraform

base infrastructure. contains hcl files for lxd machine containers on bare metal via terraform-provider-lxd. higher density compared with openstack and opennebula environments. k8s uses nodes configured by this code

- terraform
- ansible
