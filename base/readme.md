# base

`base` contains code to provision at bare metal. currently, this contains a small handful of machines

## distrobuilder

uses [distrobuilder](https://github.com/lxc/distrobuilder) to build custom lxd image. almost identical to regular ubuntu lxd images except for the custom `hostname` and `hosts` templates.

the template is filled in by values from the `user.fqdn` and `user.hostname` from the `config` block of each `corsac_containers` resource in `lxd.tf`
code to generate lxd images. used by `terraform` stage

## terraform

base infrastructure. contains hcl files for lxd machine containers on bare metal via terraform-provider-lxd. higher density compared with kvm. kubernetes uses nodes configured by this code
