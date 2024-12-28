module "cluster" {
  source = "../.."

  datastore_id = "nvme-data"

  controlplane = {
    node_count        = 1
    memory_size_in_mb = 4096
    config_patches = [{
      cluster = {
        allowSchedulingOnControlPlanes = true
      }
    }]
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
