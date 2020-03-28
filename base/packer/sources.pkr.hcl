# folder/build.pkr.hcl

source "qemu" "base_single" {
  # name = "{{user `name`}}{{user `version`}}.iso"
  # name = "${var.name}${var.version}.iso"
  format = "raw"
  accelerator = "kvm"
  net_device = "virtio-net"
  disk_interface = "virtio"
  qemuargs = [
     ["-m", local.ram],
    ["-smp", local.cpu]
  ]
  ssh_wait_timeout = "45m"
  http_directory = "."
  http_port_min = 10082
  http_port_max = 10089
  ssh_host_port_min = 2222
  ssh_host_port_max = 2229
  ssh_username = local.ssh_username
  ssh_password = local.ssh_password
  iso_urls = local.iso_urls
  iso_checksum = local.iso_checksum
  iso_checksum_type = local.iso_checksum_type
  boot_wait = "15s"
  # boot_command_prefix = "<esc><esc><enter><wait>"
  # boot_command = [
  #   "<tab><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  #   "net.ifnames=0 biosdevname=0 fb=false hostname={{user `name`}}{{user `version`}} locale=en_US ",
  #   "console-keymaps-at/keymap=us console-setup/ask_detect=false ",
  #   "console-setup/layoutcode=us keyboard-configuration/layout=USA keyboard-configuration/variant=USA ",
  #   "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/http/{{user `config_file`}} <enter><wait>"
  # ]
  disk_size = local.disk_size
  disk_discard = "unmap"
  disk_compression = true
  headless = var.headless
  shutdown_command = "echo \"${local.ssh_password}\" | sudo -S shutdown -P now"
  output_directory = "artifacts"
}
