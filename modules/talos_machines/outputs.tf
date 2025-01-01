output "cluster_name" {
  description = "Cluster name."
  value       = var.cluster_name
}

# output "kubeconfig_raw" {
#   description = "Raw kubeconfig when machine_type is controlplane."
#   value       = var.is_controlplane && var.apply && var.bootstrap ? talos_cluster_kubeconfig.this[0].kubeconfig_raw : ""
# }

# output "ip_addresses" {
#   description = "Control plane ip addresses."
#   value       = var.ip_addresses
# }

output "machine_configuration_applied" {
  description = "Applied Talos machine configuration."
  value       = talos_machine_configuration_apply.this[*].machine_configuration
}

output "machine_configuration" {
  description = "Generated Talos machine configuration."
  value       = data.talos_machine_configuration.this[*].machine_configuration
}

output "config_patches" {
  description = "Config patches used to generate the machine configuration."
  value       = local.config_patches
}

output "ipv4_addresses" {
  description = "VM Ipv4 addresses."
  value       = local.ipv4_addresses
}

output "mac_addresses" {
  description = "VM Mac addresses."
  value       = local.mac_addresses
}

output "ipv6_addresses" {
  description = "VM Ipv6 addresses."
  value       = local.ipv6_addresses
}

output "machine_names" {
  description = "VM names."
  value       = local.machine_names
}
