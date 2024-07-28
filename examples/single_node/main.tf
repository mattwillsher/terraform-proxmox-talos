module "cluster" {
  source = "../.."

  talos_version = "v1.7.5"
  datastore_id  = "nvme-data"

  metrics_server = true

  controlplane = {
    node_count = 1
    memory     = 4096
    config_patches = [{
      cluster = {
        allowSchedulingOnControlPlanes = true
      }
    }]
  }

  tags = ["kubernetes", "single-node-example"]
}

resource "local_file" "kubeconfig" {
  content  = module.cluster.kubeconfig_raw
  filename = "kubeconfig"
}

resource "local_file" "talosconfig" {
  content  = module.cluster.talos_client_configuration.talos_config
  filename = "talosconfig"
}
