provider "lxd" {
  accept_remote_certificate = false
}

resource "lxd_container" "corsac_containers" {
  count            = length(var.container_names)
  name             = "corsac-${var.container_names[count.index]}"
  image            = "ubuntu:18.04"
  profiles         = ["${lxd_profile.corsac_profile.name}"]
}

resource "lxd_profile" "corsac_profile" {
  name        = "corsac-profile"
  description = "corsac container profiles. managed by terraform-provider-lxd"

  config = {
    "limits.cpu"     = 4
  }

  device {
    type = "disk"
    name = "root"

    properties = {
      pool = "default"
      path = "/"
    }
  }

  device {
    name = var.bridged_network_name
    type = "nic"

    properties = {
      nictype = "bridged"
      parent  = var.bridged_network_name
    }
  }
}

resource "lxd_network" "corsac_network" {
  name = "corsac-network"

  config = {
    "ipv4.address" = "10.150.19.1/24"
    "ipv4.nat"     = "false"
    # "ipv6.address" = "fd42:474b:622d:259d::1/64"
    # "ipv6.nat"     = "false"
  }
}
