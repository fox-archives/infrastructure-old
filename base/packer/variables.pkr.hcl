variable "headless" {
  type = bool
  default = false
}

variable "config_file" {
  type = string
  default = "ubuntu-preseed.cfg"
}

locals {
  cpu = "2"
  ram = "2048"
  name = "ubuntu"
  version = "1804"
  disk_size = "3000"
}

locals {
  iso_checksum_type = "sha256"
  iso_urls = [
    "http://cdimage.ubuntu.com/releases/18.04.4/release/ubuntu-18.04.4-server-amd64.iso"
  ]
  iso_checksum = "e2ecdace33c939527cbc9e8d23576381c493b071107207d2040af72595f8990b"
}

locals {
  ssh_username = "root"
  ssh_password = "root-password"
}
