variable "vip_address" {
  description = "Talos Virtual IP address."
  type        = string
  validation {
    condition     = can(cidrnetmask("${var.vip_address}/32"))
    error_message = "Must be a valid IP address."
  }
}

variable "registry_mirrors" {
  description = "Map of registry mirrors to a list of mirror endpoints."
  type        = map(list(string))
  default     = null
}

variable "dns_zone" {
  description = "DNS zone for DNS record."
  type        = string
}

variable "cluster_name" {
  description = "Cluster name."
  type        = string
  default     = "talos-cilium-example"
}

variable "datastore_id" {
  description = "Proxmox datastore id."
  type        = string
  default     = "local-lvm"
}
