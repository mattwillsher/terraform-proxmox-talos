output "cluster_name" {
  description = "Cluster name."
  value       = var.cluster_name
}

output "kubeconfig_raw" {
  description = "Raw kubeconfig when machine_type is controlplane."
  value       = var.is_controlplane ? talos_cluster_kubeconfig.this[0].kubeconfig_raw : ""
}

output "ip_addresses" {
  description = "Control plane ip addresses."
  value       = var.ip_addresses
}

output "machine_configuration_applied" {
  description = "Applied Talos machine configuration."
  value       = talos_machine_configuration_apply.this[*].machine_configuration
}

output "machine_configuration" {
  description = "Generated Talos machine configuration."
  value       = data.talos_machine_configuration.this.machine_configuration
}

output "machine_config_patches" {
  description = "Config patches used to generate the machine configuration."
  value       = local.machine_config_patches
}
