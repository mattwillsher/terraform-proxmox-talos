output "iso_file_id" {
  description = "Downloaded file id."
  value       = proxmox_virtual_environment_download_file.this.id
}

output "installer_image" {
  description = "Machine image for Talos install/update"
  value       = "${var.factory_host}/installer/${talos_image_factory_schematic.this.id}:${var.talos_version}"
}
