output "installer_url" {
  description = "Machine image for Talos install/update"
  value       = var.secure_boot ? data.talos_image_factory_urls.this.urls.installer_secureboot : data.talos_image_factory_urls.this.urls.installer
}

output "talos_version" {
  description = "Selected version of Talos Linux."
  value       = local.talos_version
}

output "proxmox_iso_file_id" {
  description = "ID of the downloaded boot ISO in Proxmox."
  value       = var.download_iso ? proxmox_virtual_environment_download_file.this[0].id : null
}

output "proxmox_iso_file_name" {
  description = "Name of the downloaded boot ISO file in Proxmox, or null if not downloaded."
  value       = var.download_iso ? proxmox_virtual_environment_download_file.this[0].file_name : null
}

output "proxmox_datastore_id" {
  description = "Datastore ID where the downloaded boot ISO file is stored in Proxmox, or null if not downloaded."
  value       = var.download_iso ? proxmox_virtual_environment_download_file.this[0].datastore_id : null
}
