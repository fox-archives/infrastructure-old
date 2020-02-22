# terraform

contains terraform config to create lxd containers on bare metal.

## distrobuilder

uses [distrobuilder](https://github.com/lxc/distrobuilder) to buld custom lxd image. almost identical to regular ubuntu lxd images except for the custom `hostname` and `hosts` templates.

the template is filled in by values from the `user.fqdn` and `user.hostname` from the `config` block of each `corsac_containers` resource in `lxd.tf`
