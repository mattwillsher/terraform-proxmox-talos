run "no_secure_boot" {
  variables {
    talos_version = "v1.9.1"
    secure_boot   = false
    download_iso  = false
  }

  assert {
    condition     = output.talos_version == "v1.9.1"
    error_message = "talos_version output does not match the input value."
  }

  assert {
    condition     = output.installer_url == "factory.talos.dev/installer/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515:${var.talos_version}"
    error_message = "installer_url output is not as expected."
  }

  assert {
    condition     = output.proxmox_iso_file_id == null && output.proxmox_iso_file_name == null && output.proxmox_datastore_id == null
    error_message = "proxmox_iso_* outputs should be null as download is disabled."
  }
}

run "secure_boot_no_qemuga" {
  variables {
    talos_version            = "v1.8.1"
    disable_qemu_guest_agent = true
    download_iso             = false
  }

  assert {
    condition     = output.talos_version == var.talos_version
    error_message = "talos_version output does not match the input value."
  }

  assert {
    condition     = output.installer_url == "factory.talos.dev/installer-secureboot/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba:${var.talos_version}"
    error_message = "installer_url output is not as expected."
  }

  assert {
    condition     = output.proxmox_iso_file_id == null && output.proxmox_iso_file_name == null && output.proxmox_datastore_id == null
    error_message = "proxmox_iso_* outputs should be null as download is disabled."
  }
}

run "download" {
  variables {
    talos_version            = "v1.7.5"
    proxmox_file_name_suffix = "test"
  }

  assert {
    condition     = output.installer_url == "factory.talos.dev/installer-secureboot/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515:${var.talos_version}"
    error_message = "installer_url output is not as expected."
  }

  assert {
    condition     = output.proxmox_datastore_id == var.proxmox_datastore_id
    error_message = "proxmox_datastore_id output should be the same as the input."
  }

  assert {
    condition     = output.proxmox_iso_file_name == "talos-ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515-${var.talos_version}-test.iso"
    error_message = "proxmox_iso_file_name output is not as expected."
  }

  assert {
    condition     = output.proxmox_iso_file_id == "${var.proxmox_datastore_id}:iso/${output.proxmox_iso_file_name}"
    error_message = "proxmox_iso_file_id output should is not as expected."
  }
}