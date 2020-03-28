resource "lxd_container" "corsac_containers" {
  count            = length(var.container_names)
  name             = "corsac-${var.container_names[count.index]}"
  image            = var.cloud_image
  profiles         = [lxd_profile.corsac_profile.name]
  wait_for_network = false

  config = {
    "user.fqdn"      = "${var.container_names[count.index]}.${var.domain_name}"
    "user.hostname"  = var.container_names[count.index]
    "user.meta-data" = element(data.template_file.corsac_meta_datas.*.rendered, count.index)
    "user.user-data" = element(data.template_file.corsac_user_datas.*.rendered, count.index)
  }
}

data "template_file" "corsac_user_datas" {
  count    = length(var.container_names)
  template = file("${path.module}/user-data.yml.tpl")

  vars = {
    hostname   = var.container_names[count.index]
    domainName = var.domain_name
    sshKey     = file("${path.module}/${var.ssh_key}")
  }
}

data "template_file" "corsac_meta_datas" {
  count    = length(var.container_names)
  template = file("${path.module}/meta-data.yml.tpl")

  vars = {
    id = "60a5a5b4-5c2f-4b7c-ade5-1d07483a2725"
  }
}

resource "lxd_profile" "corsac_profile" {
  name        = "corsac-profile-default"
  description = "corsac container profiles. managed by terraform-provider-lxd"

  config = {
    "boot.autostart"              = true,
    "boot.host_shutdown_timeout"  = 20
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "50%"
    "limits.memory.enforce"       = "soft"
    "limits.memory.swap"          = true
    "limits.memory.swap.priority" = 9
    "limits.network.priority"     = 1
    "security.nesting"            = true
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
