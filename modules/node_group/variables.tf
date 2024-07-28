variable "cpu_count" {
  type        = number
  description = "Number of CPU cores."
  default     = 1
  nullable    = false
}

variable "create" {
  type        = bool
  description = "Create the node group?"
  default     = true
}

variable "datastore_id" {
  type        = string
  description = "Datastore id for EFI, TPM images."
  default     = "local-lvm"
  nullable    = false
}

variable "description" {
  type        = string
  description = "Node description."
  default     = null
}

variable "disks" {
  type        = any
  description = "Disks configuration."
  default     = [{ size = 20 }]
  nullable    = false
}

variable "iso_file_id" {
  type        = string
  description = "Install image ISO file id."
  nullable    = false
}

variable "ipconfig_ipv4" {
  description = "IPv4 address configuration."
  type        = string
  default     = "dhcp"
  nullable    = false
}

variable "ipconfig_ipv6" {
  description = "IPv6 address configuration."
  type        = string
  default     = "dhcp"
  nullable    = false
}

variable "memory_size_in_mb" {
  type        = number
  description = "Amount of memory in MB."
  default     = 2048
  nullable    = false
}

variable "name_prefix" {
  type        = string
  description = "Name prefix for nodes in the node group."
  default     = "talos"
  nullable    = false
}

variable "network_devices" {
  type        = list(map(string))
  description = "Network configuration."
  default = [{
    bridge = "vmbr0"
  }]
  nullable = false
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the group."
  default     = 1
  nullable    = false
}

variable "pool_id" {
  type        = string
  description = "Proxmox resource pool."
  default     = null
}

variable "pve_node_names" {
  type        = list(string)
  description = "Target PVE nodes to spread node_group over."
  default     = ["pve"]
  nullable    = false
}

variable "tags" {
  type        = set(string)
  description = "Set of tags for each node."
  default     = []
  nullable    = false
}

variable "machine_type" {
  type        = string
  description = "Machine type - controlplane, worker."
  default     = "worker"
  validation {
    condition     = contains(["controlplane", "worker"], var.machine_type)
    error_message = "Invalid machine type."
  }
}

variable "cpu_type" {
  type        = string
  description = "CPU type."
  default     = "x86-64-v2-AES"
}

variable "cpu_flags" {
  type        = list(string)
  description = "List of CPU flags."
  default     = null
}
