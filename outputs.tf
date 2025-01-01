output "controlplane_ip_addresses" {
  description = "List of control plane IP addresses."
  value       = local.controlplane_ip_addresses
}

output "node_ip_addresses" {
  description = "List of work node IP addresses."
  value       = local.node_ip_addresses
}

output "endpoints" {
  description = "List of cluster endpoints."
  value       = local.endpoints
}

output "kubeconfig_raw" {
  description = "Raw kubeconfig."
  value       = talos_cluster_kubeconfig.this.kubeconfig_raw
}

output "cluster_name" {
  description = "Cluster name."
  value       = module.talos_machines["controlplane"].cluster_name
}

output "machine_configurations" {
  description = "Machine configurations by node group."
  value       = { for k, v in module.talos_machines : k => v.machine_configuration }
}

output "talos_client_configuration" {
  value = data.talos_client_configuration.this
}
