output "cluster_name" {
  description = "Cluster name."
  value       = local.cluster_name
}

output "kubeconfig_raw" {
  description = "Raw kubeconfig when machine_type is controlplane."
  value       = var.machine_type == "controlplane" ? talos_cluster_kubeconfig.this[0].kubeconfig_raw : ""
}

output "ip_addresses" {
  description = "Control plane ip addresses."
  value       = var.ip_addresses
}
