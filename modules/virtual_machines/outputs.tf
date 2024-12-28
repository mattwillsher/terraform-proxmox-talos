locals {
  # Extract the network interfaces names for the Ethernet interface for each VM
  network_interface_names = [for i, vm in proxmox_virtual_environment_vm.this : one([
    for nic in vm.network_interface_names : nic
    if can(regex("^e(th\\d|n)", nic))
    ])
  ]
}

output "ipv4_addresses" {
  description = "VM Ipv4 addresses."
  value       = [for i, vm in proxmox_virtual_environment_vm.this : vm.ipv4_addresses[index(vm.network_interface_names, local.network_interface_names[i])][0]]
}

output "mac_addresses" {
  description = "VM Mac addresses."
  value       = [for i, vm in proxmox_virtual_environment_vm.this : vm.mac_addresses[index(vm.network_interface_names, local.network_interface_names[i])]]
}

output "ipv6_addresses" {
  description = "VM Ipv6 addresses."
  value       = [for i, vm in proxmox_virtual_environment_vm.this : vm.ipv6_addresses[index(vm.network_interface_names, local.network_interface_names[i])][0]]
}

output "names" {
  description = "VM names."
  value       = [for vm in proxmox_virtual_environment_vm.this : vm.name]
}

output "node_count" {
  description = "Node count."
  value       = local.node_count
}

# output "nodes" {
#   description = "Map of network interfaces."
#   value = {
#     for i, vm in proxmox_virtual_environment_vm.this : vm.name => {
#       for j, nic in vm.network_interface_names : nic => {
#         ipv4_address = vm.ipv4_addresses[j]
#         ipv6_address = vm.ipv6_addresses[j]
#         mac_address  = vm.mac_addresses[j]
#         group_name   = var.group_name
#         machine_type = var.machine_type
#       }
#     }
#   }
# }


