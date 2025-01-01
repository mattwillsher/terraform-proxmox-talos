locals {
  latest_talos_version = element(
    data.talos_image_factory_versions.this.talos_versions,
    length(data.talos_image_factory_versions.this.talos_versions) - 1
  )
  talos_version = var.talos_version != null ? var.talos_version : local.latest_talos_version
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
