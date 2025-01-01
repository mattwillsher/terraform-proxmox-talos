terraform {
  required_version = "~> 1.8"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
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

provider "proxmox" {}

provider "talos" {}
