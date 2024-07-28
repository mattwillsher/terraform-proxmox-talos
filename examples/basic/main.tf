
resource "talos_machine_secrets" "this" {}

module "cluster" {
  source = "../.."

  talos_version = "v1.7.5"

  cluster_name = "basic-example"

  datastore_id = "nvme-data"

  controlplane = {
    node_count = 3
    memory     = 2048
    tags       = ["controlplane"]
  }

  workers = {
    default = {
      node_count        = 3
      memory_size_in_mb = 2048
      tags              = ["worker"]
    }
  }

  metrics_server = true

  tags = ["kubernetes", "basic-example"]
}

resource "local_file" "kubeconfig" {
  content  = module.cluster.kubeconfig_raw
  filename = "kubeconfig"
}

resource "local_file" "talosconfig" {
  content  = module.cluster.talos_client_configuration.talos_config
  filename = "talosconfig"
}
