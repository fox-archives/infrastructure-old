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
    "http://releases.ubuntu.com/18.04.4/ubuntu-18.04.4-live-server-amd64.iso"
  ]
  iso_checksum = "73b8d860e421000a6e35fdefbb0ec859b9385b0974cf8089f5d70a87de72f6b9"
}

locals {
  ssh_username = "root"
  ssh_password = "root-password"
}
