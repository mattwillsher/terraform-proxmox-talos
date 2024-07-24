# output "control_nodes" {
#   value = module.controllers
# }

output "controlplane_ip_addresses" {
  value = module.talos["controlplane"].ip_addresses
}

output "node_ip_addresses" {
  value = flatten([for k, v in module.node_groups : v.ipv4_addresses])
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

# output "node_groups" {
#   value = local.node_groups
# }

# output "nodes" {
#   value = [for k, v in module.nodes : v.ipv4_addresses]
# }

# output "nodes" {
#   value = [for k, v in module.nodes : v.node_group]
# }

