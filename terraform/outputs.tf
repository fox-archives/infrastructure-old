output "corsac_containers" {
  value       = lxd_container.corsac_containers
  description = "lxd containers working as base for k8s cluster"
}
