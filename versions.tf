terraform {
  required_version = "~> 1.8"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "~> 0.7.0"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.69.0"
    }
  }
}
