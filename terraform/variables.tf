variable "container_names" {
  description = "unique names for each container. matches the hostname for each lxd container"
  type        = list(string)
  default     = ["xray", "yankee", "zulu"]
}

variable "bridged_network_name" {
  description = "the name or id for the bridged network interface"
  type        = string
  default     = "br0"
}

variable "cloud_image" {
  description = "cloud image that lxc uses to create machine container"
  type        = string
  default     = "ubuntu:18.04"
}
