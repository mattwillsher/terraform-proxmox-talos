variable "controlplane" {
  type        = any
  description = "Control plane configuration."
  default     = {}
}

variable "workers" {
  type        = any
  description = "Node groups configuration for workers."
  default     = {}
}

variable "cpu_count" {
  type        = number
  description = "Number of CPU core per node. (NG)."
  default     = 2
}

variable "cpu_flags" {
  type        = list(string)
  description = "List of CPU flags. (NG)."
  default     = ["+aes"]
}

variable "cpu_type" {
  type        = string
  description = "CPU type. (NG)."
  default     = "x86-64-v2-AES"
}

variable "disks" {
  type        = list(any)
  description = "Disk map. See node_group submodule for specifics. Typically only changes to size are needed. (NG)."
  default     = [{ size = 20 }]
}

variable "memory_size_in_mb" {
  type        = string
  description = "Memory size for nodes, in MB, where not otherwise specified. (NG)."
  default     = 2048
}

variable "datastore_id" {
  type        = string
  description = "Default datastore id for EFI and TPM disks and for disks where not set via the disks values(s) (NG)."
  default     = "local-lvm"
}

variable "talos_machine_secrets" {
  type        = any
  description = "Talos machine secrets."
  default     = null
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
  description = "List of tags for each node. (NG)."
  type        = list(string)
  default     = []
}

variable "vip_address" {
  description = "Virtual IP address."
  type        = string
  default     = null
}

variable "config_patches" {
  description = "Talos Linux Configuration patches as a list of maps. (NG)."
  type        = list(any)
  default     = []
}

variable "registry_mirrors" {
  description = "Map of mirror name to a list of mirror endpoints."
  type        = map(list(string))
  default     = null
}

variable "pve_node_names" {
  description = "List of Proxmox node names to distribue the VM over. Placement is round-robin. (NG)."
  type        = list(string)
  default     = ["pve"]
}

variable "cilium_version" {
  description = "Cilium version."
  type        = string
  default     = null
}

variable "cilium_cli_version" {
  description = "Cilium CLI version."
  type        = string
  default     = "latest"
}

variable "cilium" {
  description = "Install Cilium."
  type        = bool
  default     = false
}

variable "talos_version" {
  type        = string
  description = "Talos Linux version."
  default     = null
}

variable "factory_host" {
  type        = string
  description = "Image factory hostname."
  default     = "factory.talos.dev"
}

variable "installer_image" {
  type        = string
  description = "Image factory image name used for installation. If not set, use the same image version and extensions as the boot ISO."
  default     = null
}

variable "iso_file_id" {
  description = "Proxmox identifier for the boot ISO. If not set, ISO image for the talos_version will be downloaded and used. installer_image must also be provided if this options is used."
  type        = string
  default     = null
}

variable "extensions" {
  type        = list(string)
  description = "List of extensions in the image. qemu-guest-agent is included by default."
  default     = []
}

variable "image_pve_node_name" {
  type        = string
  description = "Target node to place the image on. Defaults to the first value of pve_node_names."
  default     = "pve"
}

variable "image_datastore_id" {
  type        = string
  description = "Datastore in which to store the downloadeded ISO image."
  default     = "local"
}

variable "node_labels" {
  type        = map(string)
  description = "Labels to apply to nodes. (NG)."
  default     = {}
}

variable "node_taints" {
  type        = map(string)
  description = "Taints to apply to all nodes. (NG)."
  default     = {}
}

variable "metrics_server" {
  type        = bool
  description = "Enable metrics server."
  default     = false
}

variable "talos_endpoint_hosts" {
  type        = list(string)
  description = "List of hosts to use in client Talos endpoints list. If not, set, us the IP addresses of the controlplane nodes."
  default     = null
}
