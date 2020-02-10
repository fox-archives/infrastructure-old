#cloud-config
hostname: ${hostname}
package_update: false
package_upgrade: false
locale: en_US.UTF-8
timezone: America/Los_Angelos

users:
  - default

system_info:
  distro: ubuntu
  default_user:
    name: ops
    passwd: $6$QwM7oc3p$TfPrrnIJO7ff72AXTcI7h3Y7xlDV8OSEmznjyQDck7joC9T8mEgqvhYQB7c1ADrKjpB5OH6tfhPFoRA2O9yGo1
    lock_passwd: false
    gecos: Ops
    groups: [adm, audio, cdrom, dialout, dip, floppy, lxd, netdev, plugdev, sudo, video]
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
