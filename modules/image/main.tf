data "talos_image_factory_extensions_versions" "this" {
  # get the latest talos version
  talos_version = var.talos_version
  filters = {
    names = concat(var.extensions, var.disable_qemu_guest_agent ? [] : ["qemu-guest-agent"])
  }
}

resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode(
    {
      customization = {
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.this.extensions_info[*].name
        }
      }
    }
  )
}

resource "proxmox_virtual_environment_download_file" "this" {
  content_type = "iso"
  datastore_id = var.datastore_id
  node_name    = var.pve_node_name
  url          = format("https://%s/image/%s/%s/nocloud-amd64.iso", var.factory_host, talos_image_factory_schematic.this.id, var.talos_version)
  file_name    = format("talos-%s-%s.iso", talos_image_factory_schematic.this.id, var.talos_version)
}
