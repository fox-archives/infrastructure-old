terraform {
  required_version = "=0.12.20"
}

provider "lxd" {
  # version                   = "1.3.0"
  accept_remote_certificate = false
}
