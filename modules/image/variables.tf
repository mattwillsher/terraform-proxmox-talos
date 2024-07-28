variable "pve_node_name" {
  type        = string
  description = "Target node to place the image on."
  default     = "pve"
}

variable "datastore_id" {
  type        = string
  description = "Datastore to store the image in."
  default     = "local"
}

variable "talos_version" {
  description = "Talos Linux version."
  type        = string
}

variable "factory_host" {
  description = "Image factory hostname."
  type        = string
  default     = "factory.talos.dev"
}

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

variable "id" {
  type        = string
  description = "Unique identifier for the image, postfixed the the generated name. If not set, generate a random id."
  default     = null
}
