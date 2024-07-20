variable "controlplane" {
  type        = any
  description = "Control plane configuration."
  default     = {}
}

variable "cpu_flags" {
  type        = list(string)
  description = "List of CPU flags."
  default     = ["+aes"]
}

variable "cpu_type" {
  type        = string
  description = "CPU type."
  default     = "x86-64-v2-AES"
}

variable "workers" {
  type        = any
  description = "Node groups configuration."
  default     = {}
}

variable "image" {
  type = object({
    iso_file_id     = string
    installer_image = optional(string)
  })
  description = "Talos Linux image information."
  default     = null
}

variable "datastore_id" {
  type        = string
  description = "Default datastore id."
  default     = "local-lvm"
}

variable "machine_secrets" {
  type = object({
    client_configuration = map(string)
    id                   = string
    machine_secrets      = any
  })
  description = "Talos machine secrets."
}

variable "cluster_endpoint" {
  type        = string
  description = "Cluster endpoint. Defaults to vip if provided, or else the first control plane addresses."
  default     = null
}

variable "cluster_name" {
  description = "Name of the cluster."
  type        = string
  default     = null
}

variable "tags" {
  description = "List of tags for each node."
  type        = list(string)
  default     = []
}

variable "vip_address" {
  description = "Virtal IP address."
  type        = string
  default     = null
}

variable "config_patches" {
  description = "Configuration patches for all nodes."
  type        = list(any)
  default     = []
}

variable "registry_mirrors" {
  description = "Map of mirror name to a list of mirror endpoints."
  type        = map(list(string))
  default     = null
}

variable "pve_node_names" {
  description = "List of Proxmox node names to distribue the VM over. Placement is round-robin."
  type        = list(string)
  default     = ["pve"]
}

variable "cilium_version" {
  description = "Cilium version."
  type        = string
  default     = null
}

variable "cilium_cli_version" {
  description = "Cilium CLI version"
  type        = string
  default     = "latest"
}

variable "cilium" {
  description = "Install Cilium."
  type        = bool
  default     = false
}
