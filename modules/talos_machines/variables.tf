variable "machine_secrets" {
  description = "Talos machine secrets."
  type = object({
    client_configuration = map(string)
    id                   = string
    machine_secrets      = any
  })
}

# variable "ip_addresses" {
#   description = "List of node IP addresses."
#   type        = list(string)
# }

variable "cluster_endpoint" {
  description = "Cluster endpoint."
  type        = string
}

variable "is_controlplane" {
  description = "True is the node group is of control plane node, false otherwise."
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "Name of the cluster."
  type        = string
}

variable "config_patches" {
  description = "Additional config patches."
  type        = list(map(any))
  default     = []
}

variable "machine_install_image" {
  description = "Talos install image as used in the machine configuration."
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
  default     = {}
}

variable "registry_mirrors_override_path" {
  description = "Override the registry mirrors path generation. Overrides detection of '/v2/' in the registry mirror urls."
  type        = bool
  default     = null
}

# variable "cilium" {
#   description = "Install Cilium."
#   type        = bool
#   default     = false
# }

# variable "cilium_version" {
#   description = "Cilium version, set to enable. If not set, uses Talos default CNI."
#   type        = string
#   default     = null
# }

# variable "cilium_cli_version" {
#   description = "Cilium version, set to enable. If not set, uses Talos default CNI."
#   type        = string
#   default     = "latest"
# }

variable "node_labels" {
  description = "Map of node labels to assign to nodes in the node groups."
  type        = map(any)
  default     = {}
}

variable "node_taints" {
  description = "Map of node taints to assign to nodes in the node groups."
  type        = map(any)
  default     = {}
}

# variable "metrics_server" {
#   description = "Enable metrics server on the cluster"
#   type        = bool
#   default     = false
# }

# variable "metrics_server_manifest_urls" {
#   description = "List of URLs of Kubernetes manifests to install the metrics server and associated software."
#   type        = list(string)
#   default = [
#     "https://raw.githubusercontent.com/alex1989hu/kubelet-serving-cert-approver/main/deploy/standalone-install.yaml",
#     "https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml"
#   ]
#   nullable = false
# }

variable "cluster_extra_manifests" {
  description = "List of URLs of extra manifests to apply to the cluster at bootstrap."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "apply" {
  description = "Apply the configuration."
  type        = bool
  default     = true
}

variable "cpu_count" {
  type        = number
  description = "Number of CPU cores."
  default     = 1
  nullable    = false
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

variable "machine_count" {
  type        = number
  description = "Number of machines in the group."
  default     = 1
  nullable    = false
}

variable "pool_id" {
  type        = string
  description = "Proxmox resource pool."
  default     = null
}

variable "proxmox_node_names" {
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
