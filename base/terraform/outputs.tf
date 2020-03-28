output "corsac_containers" {
  value       = "${lxd_container.corsac_containers[0]}"
  description = "lxd containers working as base for k8s cluster"
}
