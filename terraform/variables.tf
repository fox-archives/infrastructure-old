variable "container_names" {
  description = "unique names for each container. matches the hostname for each lxd container"
  type        = list(string)
  default     = ["epsilon", "zeta", "theta", "iota", "kappa"]
}

variable "domain_name" {
  description = "domain name of private internal network"
  type        = string
  default     = "corsac.internal.kofler.dev"
}

variable "bridged_network_name" {
  description = "the name or id for the bridged network interface"
  type        = string
  default     = "br0"
}

variable "cloud_image" {
  description = "image that lxc uses to create machine container"
  type        = string
  default     = "corsac-ubuntu-image"
}

variable "ssh_key" {
  description = "filename of ssh public key. this will be given to all corsac hosts"
  type        = string
  default     = "corsac-host.key.pub"
}
