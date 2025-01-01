output "machine_configurations" {
  description = "Machine configurations by node group."
  value       = yamldecode(module.cluster.machine_configurations[0])
  sensitive   = true
}
