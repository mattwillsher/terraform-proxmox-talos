terraform {
  required_version = "~> 1.10"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.69.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "~> 0.7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}
