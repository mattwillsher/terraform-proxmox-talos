
module "cluster" {
  source = "../.."

  apply = true

  talos_version = "v1.9.1"

  cluster_name = "basic-example"

  datastore_id = "nvme-data"

  controlplane = {
    machine_count = 1
    memory        = 2048
    tags          = ["controlplane"]
  }

  workers = {
    default = {
      machine_count     = 2
      memory_size_in_mb = 2048
      tags              = ["worker"]
    }
  }

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
