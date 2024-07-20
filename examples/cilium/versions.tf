terraform {
  required_version = "~> 1.8"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.61.1"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.6.0-alpha.1"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "3.4.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

provider "proxmox" {}

provider "talos" {}

provider "dns" {}
