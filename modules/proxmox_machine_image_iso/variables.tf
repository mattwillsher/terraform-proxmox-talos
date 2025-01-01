variable "node_name" {
  type        = string
  description = "Target node to place the image on."
  default     = "pve"

  validation {
    condition     = contains(local.nodes.names, var.node_name)
    error_message = "value must be a valid node name."
  }
}

variable "datastore_id" {
  type        = string
  description = "Datastore to store the image in."
  default     = "local"

  validation {
    condition     = contains(local.iso_datastores_available, var.datastore_id)
    error_message = "Datastore must be an active, enabled ISO datastore."
  }
}

variable "file_name_suffix" {
  type        = string
  description = "Suffix to append to the Proxmox file name. Set to emptry string to use a random id."
  default     = null
}

variable "iso_url" {
  type        = string
  description = "URL to download the ISO from."
}
