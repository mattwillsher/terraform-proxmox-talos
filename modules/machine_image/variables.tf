

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

variable "stable_versions_only" {
  description = "Select from and check against stable versions only."
  type        = bool
  default     = true
}

variable "secure_boot" {
  type        = bool
  description = "Enable secure boot."
  default     = true
}

variable "disable_qemu_guest_agent" {
  type        = bool
  description = "Disable the inclusion of the qemu-guest-agent extension."
  default     = false
}
