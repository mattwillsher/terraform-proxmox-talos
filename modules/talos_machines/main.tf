locals {
  // This code checks if any of the registry mirrors endpoints contain the "/v2/"
  // string. This is used to determine if the overridePath for the registry mirrors
  // should be set to the registry_mirrors_override_path variable or to true.
  mirrors_with_v2 = anytrue(flatten([for k, mirrors in var.registry_mirrors : [for mirror in mirrors : strcontains(mirror, "/v2/")]]))
  machine_install = {
    install = {
      image = var.machine_install_image
      disk  = "/dev/sda"
    }
  }
  machine_registry_mirrors = length(var.registry_mirrors) > 0 ? {
    registries = {
      mirrors = {
        for k, v in var.registry_mirrors : k => {
          endpoints    = v
          overridePath = var.registry_mirrors_override_path != null ? var.registry_mirrors_override_path : local.mirrors_with_v2
        }
      }
    }
  } : {}
  machine_vip = var.is_controlplane && var.vip_address != null ? {
    network = {
      interfaces = [{
        deviceSelector = {
          busPath = "0*"
        }
        vip = {
          ip = var.vip_address
        }
      }]
    }
  } : {}
  machine_node_labels = length(var.node_labels) > 0 ? { nodeLabels = var.node_labels } : {}
  machine_node_taints = length(var.node_taints) > 0 ? { nodeTaints = var.node_taints } : {}
  # rotate_certs = var.metrics_server ? {
  #   machine = {
  #     kubelet = {
  #       extraArgs = {
  #         rotate-server-certificates = true
  #       }
  #     }
  #   }
  # } : {}
  // Cluster configuration items
  # cilium = var.cilium && var.machine_type == "controlplane" ? templatefile("${path.module}/templates/cilium.yaml.tftpl", {
  #   version     = var.cilium_version
  #   cli_version = var.cilium_cli_version
  # }) : ""
  # metrics_server = var.metrics_server && var.machine_type == "controlplane" && length(var.metrics_server_manifest_urls) > 0 ? {
  #   cluster = {
  #     extraManifests = var.metrics_server_manifest_urls
  #   }
  # } : {}
  cluster_extra_manifests = length(var.cluster_extra_manifests) > 0 ? { extraManifests = var.cluster_extra_manifests } : {}

  machine_config_patches = { machine = merge(
    local.machine_registry_mirrors,
    local.machine_install,
    local.machine_vip,
    local.machine_node_labels,
    local.machine_node_taints,
  ) }
  cluster_config_patches = { cluster = merge(
    local.cluster_extra_manifests
  ) }
  config_patches = concat([
    yamlencode(
      merge(
        local.machine_config_patches,
        var.is_controlplane ? local.cluster_config_patches : {}
      )
    ),
    ], var.config_patches
  )

  # Extract the network interfaces names for the Ethernet interface for each VM
  network_interface_names = [for i, vm in proxmox_virtual_environment_vm.this : one([
    for nic in vm.network_interface_names : nic
    if can(regex("^e(th\\d|n)", nic))
    ])
  ]
  ipv4_addresses = [
    for i, vm in proxmox_virtual_environment_vm.this : vm.ipv4_addresses[
      index(vm.network_interface_names, local.network_interface_names[i])
    ][0]
  ]
  ipv6_addresses = [
    for i, vm in proxmox_virtual_environment_vm.this : vm.ipv6_addresses[
      index(vm.network_interface_names, local.network_interface_names[i])
    ][0]
  ]
  mac_addresses = [
    for i, vm in proxmox_virtual_environment_vm.this : vm.mac_addresses[
      index(vm.network_interface_names, local.network_interface_names[i])
    ]
  ]
  machine_names = [for vm in proxmox_virtual_environment_vm.this : vm.name]
  cluster_endpoint = coalesce(var.cluster_endpoint, format("https://%s:6443", coalesce(
    var.vip_address,
    local.ipv4_addresses[0]
    )
    )
  )
}

data "talos_machine_configuration" "this" {
  cluster_name     = var.cluster_name
  cluster_endpoint = local.cluster_endpoint

  machine_type    = var.is_controlplane ? "controlplane" : "worker"
  machine_secrets = var.machine_secrets.machine_secrets

  config_patches = local.config_patches
}

resource "talos_machine_configuration_apply" "this" {
  count = var.machine_count * (var.apply ? 1 : 0)

  client_configuration        = var.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.this.machine_configuration

  node = local.ipv4_addresses[count.index]
}

resource "random_id" "this" {
  count = var.machine_count

  byte_length = 4
}

resource "proxmox_virtual_environment_vm" "this" {
  count = var.machine_count

  name        = "${var.name_prefix}${random_id.this[count.index].hex}"
  description = var.description
  pool_id     = var.pool_id
  tags        = var.tags

  node_name     = element(var.proxmox_node_names, count.index)
  machine       = "q35"
  bios          = "ovmf"
  scsi_hardware = "virtio-scsi-single"

  on_boot    = "true"
  boot_order = ["scsi0", "ide0"]

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

  tpm_state {
    datastore_id = var.datastore_id
    version      = "v2.0"
  }

  efi_disk {
    datastore_id = var.datastore_id
    type         = "4m"
  }

  operating_system {
    type = "l26"
  }

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

  serial_device {}
}
