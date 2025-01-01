locals {
  nodes      = data.proxmox_virtual_environment_nodes.this
  datastores = data.proxmox_virtual_environment_datastores.this
  iso_datastores_available = [
    for i, datastore in local.datastores.datastore_ids : datastore
    if contains(local.datastores.content_types[i], "iso") && local.datastores.active[i] && local.datastores.enabled[i]
  ]
  # iso_file_name = format("talos-nocloud-%s-%s%s%s.iso",
  #   talos_image_factory_schematic.this.id,
  #   var.talos_version,
  #   var.secure_boot ? "-secureboot" : "",
  #   coalesce(try(random_id.proxmox_file_name_suffix[0].hex, null), var.proxmox_file_name_suffix, "")
  # )
  iso_url_list = split("/", var.iso_url)
  iso_file_name = format("talos-%s-%s-%s-%s.iso",
    replace(local.iso_url_list[length(local.iso_url_list) - 1], ".iso", ""),
    local.iso_url_list[4], local.iso_url_list[5],
    coalesce(var.file_name_suffix, random_id.proxmox_file_name_suffix.hex)
  )
}

data "proxmox_virtual_environment_nodes" "this" {}

data "proxmox_virtual_environment_datastores" "this" {
  node_name = var.node_name
}

resource "random_id" "proxmox_file_name_suffix" {
  byte_length = 4
}

# TODO: Once data source is implemented, can query and return
# existing datasource
# https://github.com/bpg/terraform-provider-proxmox/issues/1396
resource "proxmox_virtual_environment_download_file" "this" {
  content_type = "iso"
  datastore_id = var.datastore_id
  node_name    = var.node_name
  url          = var.iso_url
  file_name    = local.iso_file_name
}
