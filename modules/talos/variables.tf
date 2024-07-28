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

variable "metrics_server" {
  description = "Enable metrics server on the cluster"
  type        = bool
  default     = false
}

variable "metrics_server_manifest_urls" {
  description = "List of URLs of Kubernetes manifests to install the metrics server and associated software."
  type        = list(string)
  default = [
    "https://raw.githubusercontent.com/alex1989hu/kubelet-serving-cert-approver/main/deploy/standalone-install.yaml",
    "https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml"
  ]
  nullable = false
}

variable "extra_manifests" {
  description = "List of URLs of extra manifests to apply at bootstrap."
  type        = list(string)
  default     = []
  nullable    = false
}
