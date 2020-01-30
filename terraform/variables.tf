variable "container_names" {
  description = "unique names for each container. matches the hostname for each lxd container"
  type        = list(string)
  default     = ["alfa", "bravo", "charlie"]
}
