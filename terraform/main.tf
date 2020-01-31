provider "lxd" {
  access_key=""
  secret_key=""
  profile=""
}

provider "aws" {
  access_key=""
  secret_key=""
  profile=""
  shared_credentials_file=""
  region=""
  assume_role=""
}

resource "lxd_container" "corsac_containers" {
  count            = length(var.container_names)
  name             = "corsac-${var.container_names[count.index]}"
  image            = "ubuntu:18.04"
  profiles         = ["${lxd_profile.corsac_network_profile.name}"]
  wait_for_network = false
}

resource "lxd_profile" "corsac_network_profile" {
  name = "corsac-network"

  config = {
    "limits.cpu"     = 2
    "boot.autostart" = true
  }

  device {
    type = "disk"
    name = "root"

    properties = {
      pool = "default"
      path = "/"
    }
  }
}

output "foo" {
  value       = lxd_profile.corsac_network_profile.name
  description = "this is the network profile value"
}
