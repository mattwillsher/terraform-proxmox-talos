variable "machine_secrets" {
  description = "Talos machine secrets."
  type = object({
    client_configuration = map(string)
    id                   = string
    machine_secrets      = any
  })
}

variable "ip_addresses" {
  description = "List of node IP addresses."
  type        = list(string)
}

variable "cluster_endpoint" {
  description = "Cluster endpoint."
  type        = string
}

variable "machine_type" {
  description = "Machine type - controlplane, worker."
  type        = string
  default     = "worker"
}

variable "node_count" {
  description = "Number of nodes in the group."
  type        = number
}

variable "cluster_name" {
  description = "Name of the cluster."
  type        = string
  default     = null
}

variable "config_patches" {
  description = "Additional config patches, YAML encoded."
  type        = list(string)
  default     = []
}

variable "installer_image" {
  description = "Talos installer image."
  type        = string
}

variable "vip_address" {
  description = "Virtual IP address, only used for contarolplane nodes."
  type        = string
  default     = null
}

variable "registry_mirrors" {
  description = "Map of mirror name to a list of mirror endpoints."
  type        = map(list(string))
  default     = null
}

variable "cilium" {
  description = "Install Cilium."
  type        = bool
  default     = false
}

variable "cilium_version" {
  description = "Cilium version, set to enable. If not set, uses Talos default CNI."
  type        = string
  default     = null
}

variable "cilium_cli_version" {
  description = "Cilium version, set to enable. If not set, uses Talos default CNI."
  type        = string
  default     = "latest"
}
