# corsac 

an iaas i'm setting up on my hardware to help my friends create 'production-grade', statefull public-facing services. or just playing around in an (optionally ephemeral) rootfull linux environment

## usage

if you wish to setup this system for yourself

supported platforms

- ubuntu 18.04

### prerequisites

- docker
- docker-compose
- make
- terraform
- terraform-provider-lxd
- ansible

can use `install.sh` to install these dependencies

## installation

```sh
git clone https://github.com/eankeen/corsac
cd corsac
```

## overview

### terraform

base infrastructure. contains hcl files for lxd machine containers on bare metal via terraform-provider-lxd. higher density compared with openstack and opennebula environments. k8s uses nodes configured by this code

- terraform
- ansible
