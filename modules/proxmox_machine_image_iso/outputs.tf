
output "file_id" {
  description = "ID of the downloaded boot ISO in Proxmox."
  value       = proxmox_virtual_environment_download_file.this.id
}

output "file_name" {
  description = "Name of the downloaded boot ISO file in Proxmox, or null if not downloaded."
  value       = proxmox_virtual_environment_download_file.this.file_name
}

output "datastore_id" {
  description = "Datastore ID where the downloaded boot ISO file is stored in Proxmox, or null if not downloaded."
  value       = proxmox_virtual_environment_download_file.this.datastore_id
}
