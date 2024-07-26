locals {
  # Generated cluster name in case one is not specificed.
  cluster_name = coalesce(var.cluster_name, "talos-cluster-${random_id.cluster_name[0].hex}")
  # Map containing the full, node group configurations. 
  # Values can also come from cluster wide values specified as explicit variables,
  # but the values in this node_group take priority.
  node_groups = merge({
    # controlplane is a special case and used for the control plane nodes and as such
    # it must always exist. These values will get overwritten from the controlplane input
    # map variable as needed.
    controlplane = merge({
      name_prefix  = "talos-ctrl-"
      machine_type = "controlplane"
      node_count   = 3
      }
    , var.controlplane)
  }, var.workers)
}

# Random ID for use where a cluster_name input variable has not been
# specified. 
resource "random_id" "cluster_name" {
  count       = var.cluster_name == null ? 1 : 0
  byte_length = 4
}

module "image" {
  count  = var.iso_file_id != null ? 1 : 0
  source = "./modules/image"

  talos_version = var.talos_version
  factory_host  = var.factory_host
  extensions    = var.extensions

  id = local.cluster_name

  pve_node_name = var.image_pve_node_name
  datastore_id  = var.image_datastore_id
}

module "node_groups" {
  source = "./modules/node_group"

  for_each = local.node_groups

  name_prefix = try(each.value.name_prefix, "talos-wrkr-${each.key}-")

  machine_type = try(each.value.machine_type, "worker")

  node_count = try(each.value.node_count, null)

  pve_node_names = try(each.value.pve_node_names, var.pve_node_names, null)
  pool_id        = try(each.value.pool_id, null)

  cpu_count         = try(each.value.cpu_count, var.cpu_count, null)
  cpu_flags         = try(each.value.cpu_flags, var.cpu_flags, null)
  cpu_type          = try(each.value.cpu_type, var.cpu_type, null)
  memory_size_in_mb = try(each.value.memory_size_in_mb, var.memory_size_in_mb, null)

  datastore_id = var.datastore_id
  iso_file_id  = coalesce(var.iso_file_id, module.image[0].iso_file_id)
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

  installer_image = coalesce(var.installer_image, module.image[0].installer_image)

  # yamlencode as list of mixed elements can't be concatenated. https://github.com/hashicorp/terraform/issues/33259
  config_patches = concat(
    [for p in var.config_patches : yamlencode(p)],
    [for p in try(local.node_groups[each.key].config_patches, []) : yamlencode(p)]
  )

  machine_secrets = var.machine_secrets
  machine_type    = each.value.machine_type

  cluster_name     = local.cluster_name
  cluster_endpoint = coalesce(var.cluster_endpoint, format("https://%s:6443", coalesce(var.vip_address, module.node_groups["controlplane"].ipv4_addresses[0])))

  ip_addresses = each.value.ipv4_addresses
  vip_address  = var.vip_address

  registry_mirrors = var.registry_mirrors

  metrics_server = var.metrics_server

  cilium             = var.cilium
  cilium_cli_version = var.cilium_cli_version
  cilium_version     = var.cilium_version

  node_labels = merge(var.node_labels, try(each.value.node_labels, {}))
  node_taints = merge(var.node_taints, try(each.value.node_taints, {}))
}
