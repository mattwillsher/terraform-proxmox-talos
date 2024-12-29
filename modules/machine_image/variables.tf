variable "proxmox_node_name" {
  type        = string
  description = "Target node to place the image on."
  default     = "pve"

  validation {
    condition     = contains(local.proxmox_nodes.names, var.proxmox_node_name)
    error_message = "value must be a valid node name."
  }
}

variable "proxmox_datastore_id" {
  type        = string
  description = "Datastore to store the image in."
  default     = "local"

  validation {
    condition     = contains(local.proxmox_available_iso_datastores, var.proxmox_datastore_id)
    error_message = "Datastore must be an active, enabled ISO datastore."
  }
}

variable "talos_version" {
  description = "Talos Linux version."
  type        = string
  default     = null

  validation {
    condition     = var.talos_version == null ? true : contains(data.talos_image_factory_versions.this.talos_versions, var.talos_version)
    error_message = "Provided Talos Linux version is not valid."
  }
}

# variable "factory_host" {
#   description = "Image factory hostname."
#   type        = string
#   default     = "factory.talos.dev"
# }

variable "extensions" {
  description = "List of extensions in the image. qemu-guest-agent is included by default."
  type        = list(string)
  default     = []
}

variable "disable_qemu_guest_agent" {
  type        = bool
  description = "Do not include the qemu guest agent."
  default     = false
}

variable "proxmox_file_name_suffix" {
  type        = string
  description = "Suffix to append to the Proxmox file name to make it unique per run. If not provided, a random suffix is generated."
  default     = null
}

variable "secure_boot" {
  type        = bool
  description = "Enable secure boot."
  default     = true
}

variable "stable_versions_only" {
  description = "Select from and check against stable versions only."
  type        = bool
  default     = true
}

variable "download_iso" {
  description = "If set to true, download the Talos Linux ISO to the Proxmox datastore."
  type        = bool
  default     = true
}
