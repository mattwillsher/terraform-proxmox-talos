run "invalid_proxmox_host" {

  command = plan

  variables {
    talos_version     = "v1.9.1"
    proxmox_node_name = "invalid"
    download_iso      = false
  }

  expect_failures = [
    var.proxmox_node_name,
  ]

  # assert {
  #   condition     = output.talos_version == "v1.9.1"
  #   error_message = "talos_version output does not match the input value."
  # }
}

run "invalid_datastore" {

  command = plan

  variables {
    talos_version        = "v1.9.1"
    proxmox_datastore_id = "invalid"
    download_iso         = false
  }

  expect_failures = [
    var.proxmox_datastore_id,
  ]

  # assert {
  #   condition     = output.talos_version == "v1.9.1"
  #   error_message = "talos_version output does not match the input value."
  # }
}