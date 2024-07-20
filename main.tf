locals {
  node_groups = merge({
    controlplane = merge({
      name_prefix       = "talos-ctrl-"
      machine_type      = "controlplane"
      node_count        = 3
      cpu_count         = 2
      memory_size_in_mb = 2048
      }
    , var.controlplane)
  }, var.workers)
}

module "node_groups" {
  source = "./modules/node_group"

  for_each = local.node_groups

  name_prefix = try(each.value.name_prefix, "talos-wrkr-${each.key}-")

  machine_type = try(each.value.machine_type, "worker")

  node_count = try(each.value.node_count, null)

  pve_node_names = try(each.value.pve_node_names, var.pve_node_names, null)
  pool_id        = try(each.value.pool_id, null)

  cpu_count         = try(each.value.cpu_count, null)
  cpu_flags         = try(each.value.cpu_flags, var.cpu_flags, null)
  cpu_type          = try(each.value.cpu_type, var.cpu_type, null)
  memory_size_in_mb = try(each.value.memory_size_in_mb, null)

  datastore_id = var.datastore_id
  iso_file_id  = try(each.value.iso_file_id, var.image.iso_file_id, null)
  disks        = try(each.value.disks, null)

  network_devices = lookup(each.value, "network_devices", null)
  ipconfig_ipv4   = try(each.value.ipconfig_ipv4, null)
  ipconfig_ipv6   = try(each.value.ipconfig_ipv6, null)

  tags = concat(try(each.value.tags, []), var.tags)
}

module "talos" {
  for_each = module.node_groups

  source = "./modules/talos"

  node_count = each.value.node_count

  installer_image = var.image.installer_image

  # yamlencode as list of mixed elements can't be concatenated. https://github.com/hashicorp/terraform/issues/33259
  config_patches = concat(
    [for p in var.config_patches : yamlencode(p)],
    [for p in try(local.node_groups[each.key].config_patches, []) : yamlencode(p)]
  )

  machine_secrets = var.machine_secrets
  machine_type    = each.value.machine_type

  cluster_name     = var.cluster_name
  cluster_endpoint = coalesce(var.cluster_endpoint, format("https://%s:6443", coalesce(var.vip_address, module.node_groups["controlplane"].ipv4_addresses[0])))
  ip_addresses     = each.value.ipv4_addresses

  vip_address      = var.vip_address
  registry_mirrors = var.registry_mirrors

  cilium             = var.cilium
  cilium_cli_version = var.cilium_cli_version
  cilium_version     = var.cilium_version
}
