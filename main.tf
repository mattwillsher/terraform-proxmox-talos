locals {
  # Generated cluster name in case one is not specificed.
  cluster_name = coalesce(var.cluster_name,
    try(
      "talos-${random_id.cluster_name[0].hex}",
      "talos-proxmox"
    )
  )
  # Map containing the full machine group configurations.
  machine_groups = merge({
    # controlplane is a special case and used for the control plane nodes and as such
    # it must always exist. These values will get overwritten from the controlplane input
    # map variable as needed.
    controlplane = merge({
      is_controlplane = true
      node_count      = 3
      }, var.controlplane
    )
  }, var.workers)

  controlplane_ip_addresses = module.talos_linux["controlplane"].ip_addresses
  node_ip_addresses         = flatten([for k, v in module.virtual_machines : v.ipv4_addresses])
  machine_secrets           = var.talos_machine_secrets != null ? var.talos_machine_secrets : talos_machine_secrets.this[0]
}

# Random ID for use where a cluster_name input variable has not been
# specified. 
resource "random_id" "cluster_name" {
  count       = var.cluster_name == null ? 1 : 0
  byte_length = 4
}

resource "talos_machine_secrets" "this" {
  count         = var.talos_machine_secrets == null ? 1 : 0
  talos_version = module.machine_image[0].talos_version
}

data "talos_client_configuration" "this" {
  cluster_name         = local.cluster_name
  client_configuration = local.machine_secrets.client_configuration
  endpoints            = coalesce(var.talos_endpoint_hosts, local.controlplane_ip_addresses)
  nodes                = local.node_ip_addresses
}

module "machine_image" {
  count  = var.iso_file_id == null ? 1 : 0
  source = "./modules/machine_image"

  talos_version        = var.talos_version
  stable_versions_only = var.stable_versions_only
  # factory_host  = var.factory_host
  extensions  = var.extensions
  secure_boot = var.secure_boot

  proxmox_node_name        = var.image_pve_node_name
  proxmox_datastore_id     = var.image_datastore_id
  proxmox_file_name_suffix = local.cluster_name
}

module "virtual_machines" {
  source = "./modules/virtual_machines"

  for_each = local.machine_groups

  name_prefix = try(each.value.name_prefix, "${local.cluster_name}-${each.key}-")

  node_count = try(each.value.node_count, null)

  pve_node_names = try(each.value.pve_node_names, var.pve_node_names, null)
  pool_id        = try(each.value.pool_id, null)

  cpu_count         = try(each.value.cpu_count, var.cpu_count, null)
  cpu_flags         = try(each.value.cpu_flags, var.cpu_flags, null)
  cpu_type          = try(each.value.cpu_type, var.cpu_type, null)
  memory_size_in_mb = try(each.value.memory_size_in_mb, var.memory_size_in_mb, null)

  datastore_id = try(each.value.datastore_id, var.datastore_id)
  iso_file_id  = coalesce(var.iso_file_id, module.machine_image[0].proxmox_iso_file_id)
  disks        = try(each.value.disks, var.disks, null)

  network_devices = lookup(each.value, "network_devices", null)
  ipconfig_ipv4   = try(each.value.ipconfig_ipv4, null)
  ipconfig_ipv6   = try(each.value.ipconfig_ipv6, null)

  tags = concat(try(each.value.tags, []), var.tags)
}

module "talos_linux" {
  for_each = module.virtual_machines

  source = "./modules/talos_linux"

  node_count = each.value.node_count

  machine_install_image = coalesce(var.machine_install_image, module.machine_image[0].installer_url)

  # yamlencode as list of mixed elements can't be concatenated. https://github.com/hashicorp/terraform/issues/33259
  config_patches = concat(var.config_patches, try(local.machine_groups[each.key].config_patches, []))

  machine_secrets = local.machine_secrets
  is_controlplane = try(local.machine_groups[each.key].is_controlplane, false)

  cluster_name = local.cluster_name
  cluster_endpoint = coalesce(
    var.cluster_endpoint,
    format("https://%s:6443", coalesce(
      var.vip_address,
      module.virtual_machines["controlplane"].ipv4_addresses[0]
      )
    )
  )

  ip_addresses = each.value.ipv4_addresses
  vip_address  = var.vip_address

  registry_mirrors               = var.registry_mirrors
  registry_mirrors_override_path = var.registry_mirrors_override_path

  # metrics_server = var.metrics_server

  # cilium             = var.cilium
  # cilium_cli_version = var.cilium_cli_version
  # cilium_version     = var.cilium_version

  node_labels = merge(var.node_labels, try(local.machine_groups[each.key].node_labels, {}))
  node_taints = merge(var.node_taints, try(local.machine_groups[each.key].node_taints, {}))
}
