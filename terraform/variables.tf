variable "container_names" {
  description = "unique names for each container. matches the hostname for each lxd container"
  type        = list(string)
  default     = ["alfa", "bravo", "charlie"]
}

variable "bridged_network_name" {
  description = "the name or id for the bridged network interface"
  type = string
  default = "br0"
}
