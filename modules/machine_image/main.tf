locals {
  latest_talos_version = element(
    data.talos_image_factory_versions.this.talos_versions,
    length(data.talos_image_factory_versions.this.talos_versions) - 1
  )
  talos_version      = var.talos_version != null ? var.talos_version : local.latest_talos_version
  proxmox_nodes      = data.proxmox_virtual_environment_nodes.this
  proxmox_datastores = data.proxmox_virtual_environment_datastores.this
  proxmox_available_iso_datastores = [
    for i, datastore in local.proxmox_datastores.datastore_ids : datastore
    if contains(local.proxmox_datastores.content_types[i], "iso") && local.proxmox_datastores.active[i] && local.proxmox_datastores.enabled[i]
  ]
}

data "proxmox_virtual_environment_nodes" "this" {}

data "proxmox_virtual_environment_datastores" "this" {
  node_name = var.proxmox_node_name
}

data "talos_image_factory_versions" "this" {
  filters = {
    stable_versions_only = var.stable_versions_only
  }
}

data "talos_image_factory_extensions_versions" "this" {
  talos_version = local.talos_version
  filters = {
    names = concat(var.extensions, var.disable_qemu_guest_agent ? [] : ["siderolabs/qemu-guest-agent"])
  }

  lifecycle {
    postcondition {
      condition     = length(coalesce(self.extensions_info, [])) == length(var.extensions) + (var.disable_qemu_guest_agent ? 0 : 1)
      error_message = "Specified extension(s) do not exist."
    }
  }
}

data "talos_image_factory_urls" "this" {
  talos_version = local.talos_version
  schematic_id  = talos_image_factory_schematic.this.id
  platform      = "nocloud"
}

# https://github.com/siderolabs/image-factory?tab=readme-ov-file#post-schematics
resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode(
    merge(
      {
        customization = {
          systemExtensions = {
            officialExtensions = data.talos_image_factory_extensions_versions.this.extensions_info == null ? [] : data.talos_image_factory_extensions_versions.this.extensions_info[*].name
          }
        }
      },
      var.secure_boot ? { secureboot = { includeWellKnownCertificates = true } } : {}
    )
  )
}

resource "random_id" "id" {
  count       = var.proxmox_file_name_suffix == null ? 1 : 0
  byte_length = 4
}

resource "proxmox_virtual_environment_download_file" "this" {
  count        = var.download_iso ? 1 : 0
  content_type = "iso"
  datastore_id = var.proxmox_datastore_id
  node_name    = var.proxmox_node_name
  url          = var.secure_boot ? data.talos_image_factory_urls.this.urls.iso_secureboot : data.talos_image_factory_urls.this.urls.iso
  # url = format("https://%s/image/%s/%s/nocloud-amd64%s.iso",
  #   var.factory_host,
  #   talos_image_factory_schematic.this.id,
  #   local.talos_version,
  #   var.secure_boot ? "-secureboot" : ""
  # )
  file_name = format("talos-%s-%s-%s.iso",
    talos_image_factory_schematic.this.id,
    local.talos_version,
    var.proxmox_file_name_suffix == null ? random_id.id[0].hex : var.proxmox_file_name_suffix
  )
}
