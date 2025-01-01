output "talos_version" {
  description = "Selected version of Talos Linux."
  value       = local.talos_version
}

output "schematic_id" {
  description = "Image schematic id."
  value       = talos_image_factory_schematic.this.id
}

output "installer" {
  description = "Machine image for Talos install/update"
  value       = var.secure_boot ? data.talos_image_factory_urls.this.urls.installer_secureboot : data.talos_image_factory_urls.this.urls.installer
}

output "iso_url" {
  description = "URL for the Talos ISO image."
  value       = var.secure_boot ? data.talos_image_factory_urls.this.urls.iso_secureboot : data.talos_image_factory_urls.this.urls.iso
}
