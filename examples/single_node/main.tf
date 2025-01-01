module "cluster" {
  source = "../.."

  datastore_id = "local-lvm"

  controlplane = {
    node_count        = 1
    memory_size_in_mb = 4096
    config_patches = [{
      cluster = {
        allowSchedulingOnControlPlanes = true
      }
    }]
    disks = [
      { size = 20, interface = "scsi0" },
      { size = 10, interface = "scsi1" }
    ]
  }

  tags = ["kubernetes", "single-node-example"]
}

resource "local_file" "kubeconfig" {
  content         = module.cluster.kubeconfig_raw
  filename        = "kubeconfig"
  file_permission = "0600"
}

resource "local_file" "talosconfig" {
  content         = module.cluster.talos_client_configuration.talos_config
  filename        = "talosconfig"
  file_permission = "0600"
}
