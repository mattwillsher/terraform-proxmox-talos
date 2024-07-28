output "controlplane_ip_addresses" {
  value = local.controlplane_ip_addresses
}

output "node_ip_addresses" {
  value = local.node_ip_addresses
}

output "kubeconfig_raw" {
  description = "Raw kubeconfig."
  value       = module.talos["controlplane"].kubeconfig_raw
}

output "cluster_name" {
  description = "Cluster name."
  value       = module.talos["controlplane"].cluster_name
}

output "machine_configurations" {
  description = "Machine configurations by node group."
  value       = [for k, v in module.talos : v.machine_configuration]
}

output "talos_client_configuration" {
  value = data.talos_client_configuration.this
}
