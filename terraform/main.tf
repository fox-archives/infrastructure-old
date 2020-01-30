resource "lxd_container" "lxd_corsac_1" {
  name  = "corsac-1"
  image = "ubuntu:18.04"
  profiles = ["${lxd_profile.lxd_corsac_network.name}"]
  wait_for_network = false
}

resource "lxd_profile" "lxd_corsac_network" {
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

output "ip_c_1" {
  value = "${lxd_container.lxd_corsac_1.ip_address}"
}

