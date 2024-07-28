resource "random_id" "this" {
  count = var.node_count

  byte_length = 4
}

locals {
  node_count = var.node_count * (var.create == true ? 1 : 0)
}

resource "proxmox_virtual_environment_vm" "this" {
  count = local.node_count

  name        = "${var.name_prefix}${random_id.this[count.index].hex}"
  description = var.description
  pool_id     = var.pool_id
  tags        = var.tags

  node_name     = element(var.pve_node_names, count.index)
  machine       = "q35"
  bios          = "seabios"
  scsi_hardware = "virtio-scsi-single"

  on_boot = "true"

  agent {
    enabled = true
  }

  cpu {
    cores = var.cpu_count
    type  = var.cpu_type
    flags = var.cpu_flags
  }

  memory {
    dedicated = var.memory_size_in_mb
  }

  # tpm_state {
  #   version      = "v2.0"
  #   datastore_id = var.datastore_id
  # }

  # efi_disk {
  #   datastore_id = var.datastore_id
  #   type         = "4m"
  # }

  cdrom {
    enabled   = true
    interface = "ide0"
    file_id   = var.iso_file_id
  }

  initialization {
    datastore_id = var.datastore_id
    interface    = "ide2"
    ip_config {
      ipv4 {
        address = var.ipconfig_ipv4
      }
      ipv6 {
        address = var.ipconfig_ipv6
      }
    }
  }

  dynamic "disk" {
    for_each = var.disks
    content {
      datastore_id = try(disk.value.datastore_id, var.datastore_id)
      interface    = try(disk.value.interface, "scsi0")
      size         = try(disk.value.size, 20)
      file_format  = try(disk.value.file_format, "raw")
      iothread     = try(disk.value.iothread, true)
      discard      = try(disk.value.discard, "on")
      ssd          = try(disk.value.ssd, true)
    }
  }

  dynamic "network_device" {
    for_each = var.network_devices
    content {
      bridge = network_device.value.bridge
    }
  }

  operating_system {
    type = "l26"
  }

  serial_device {}
}
