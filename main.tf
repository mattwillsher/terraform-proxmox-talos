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
      machine_count   = 1
      }, var.controlplane
    )
  }, var.workers)

  controlplane_ip_addresses = module.talos_machines["controlplane"].ipv4_addresses
  node_ip_addresses         = flatten([for k, v in module.talos_machines : v.ipv4_addresses])
  endpoints = coalesce(
    var.talos_endpoint_hosts,
    var.vip_address == null ? null : [var.vip_address],
    local.controlplane_ip_addresses
  )
  machine_secrets = coalesce(var.talos_machine_secrets, talos_machine_secrets.this[0])
}

data "talos_client_configuration" "this" {
  cluster_name         = local.cluster_name
  client_configuration = local.machine_secrets.client_configuration
  endpoints            = local.endpoints
  nodes                = local.node_ip_addresses
}

# Random ID for use where a cluster_name input variable has not been
# specified. 
resource "random_id" "cluster_name" {
  count       = var.cluster_name == null ? 1 : 0
  byte_length = 4
}

resource "talos_machine_secrets" "this" {
  count         = var.talos_machine_secrets == null ? 1 : 0
  talos_version = module.default_machine_image.talos_version
}

resource "talos_machine_bootstrap" "this" {
  count = var.apply && var.bootstrap ? 1 : 0

  client_configuration = local.machine_secrets.client_configuration
  node                 = local.controlplane_ip_addresses[0]
}

resource "talos_cluster_kubeconfig" "this" {
  client_configuration = local.machine_secrets.client_configuration
  node                 = local.controlplane_ip_addresses[0]
}

module "default_machine_image" {
  source = "./modules/machine_image"

  talos_version        = var.talos_version
  stable_versions_only = var.stable_versions_only
  extensions           = var.extensions
  secure_boot          = var.secure_boot
}

module "default_boot_iso" {
  source = "./modules/proxmox_machine_image_iso"

  node_name    = var.image_pve_node_name
  datastore_id = var.image_datastore_id
  iso_url      = module.default_machine_image.iso_url
}

module "talos_machines" {
  for_each = local.machine_groups

  source = "./modules/talos_machines"

  machine_count = try(each.value.machine_count, null)

  apply = var.apply

  name_prefix = try(each.value.name_prefix, "${local.cluster_name}-${each.key}-")

  proxmox_node_names = try(each.value.pve_node_names, var.pve_node_names, null)
  pool_id            = try(each.value.pool_id, null)

  cpu_count         = try(each.value.cpu_count, var.cpu_count, null)
  cpu_flags         = try(each.value.cpu_flags, var.cpu_flags, null)
  cpu_type          = try(each.value.cpu_type, var.cpu_type, null)
  memory_size_in_mb = try(each.value.memory_size_in_mb, var.memory_size_in_mb, null)

  datastore_id = try(each.value.datastore_id, var.datastore_id)
  iso_file_id  = coalesce(try(each.value.iso_file_id, null), var.iso_file_id, module.default_boot_iso.file_id)

  disks = try(each.value.disks, var.disks, null)

  network_devices = lookup(each.value, "network_devices", null)

  tags = concat(try(each.value.tags, []), var.tags)

  machine_install_image = coalesce(
    try(each.value.machine_installer_image, null),
    var.machine_installer_image,
    module.default_machine_image.installer
  )

  # yamlencode as list of mixed elements can't be concatenated. https://github.com/hashicorp/terraform/issues/33259
  config_patches = concat(
    [for p in var.config_patches : yamlencode(p)],
    [for p in try(each.value.config_patches, []) : yamlencode(p)]
  )

  machine_secrets = local.machine_secrets
  is_controlplane = try(each.value.is_controlplane, false)

  cluster_name     = local.cluster_name
  cluster_endpoint = var.cluster_endpoint
  # format("https://%s:6443", coalesce(
  #   var.vip_address,
  #   module.virtual_machines["controlplane"].ipv4_addresses[0]
  #   )
  # )

  vip_address = var.vip_address

  registry_mirrors               = var.registry_mirrors
  registry_mirrors_override_path = var.registry_mirrors_override_path
  # metrics_server = var.metrics_server

  # cilium             = var.cilium
  # cilium_cli_version = var.cilium_cli_version
  # cilium_version     = var.cilium_version

  node_labels = merge(var.node_labels, try(each.value.node_labels, {}))
  node_taints = merge(var.node_taints, try(each.value.node_taints, {}))
}
