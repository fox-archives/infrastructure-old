provider "lxd" {
  accept_remote_certificate = false
}

resource "lxd_container" "corsac_containers" {
  count            = length(var.container_names)
  name             = "corsac-${var.container_names[count.index]}"
  image            = "ubuntu:18.04"
  profiles         = ["${lxd_profile.corsac_network_profile.name}"]
}

resource "lxd_profile" "corsac_network_profile" {
  name        = "corsac-network"
  description = "corsac-network profiles. managed by terraform-provider-lxd"

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
    name = "br0"
    type = "nic"

    properties = {
      nictype = "bridged"
      parent  = "br0"
    }
  }
}
