# terraform

contains terraform config to create lxd containers on bare metal.

## notes

- when creating an lxd machine container, the hostname will be the actual name of the lxd container (ex. corsac-epsilon). to get around this, you can use the scripts in this directory to create a custom lxd image with templates that differ from the default. these take in the values from the `user.fqdn` and `user.hostname` from the `config` block of each `corsac_containers` resource. for now, it's not automated as much
