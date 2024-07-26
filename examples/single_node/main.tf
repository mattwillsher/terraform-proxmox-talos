data "talos_client_configuration" "this" {
  cluster_name         = module.cluster.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = module.cluster.controlplane_ip_addresses
  nodes                = module.cluster.node_ip_addresses
}

resource "talos_machine_secrets" "this" {}

module "cluster" {
  source = "../.."

  talos_version = "v1.7.5"
  datastore_id  = "nvme-data"

  machine_secrets = talos_machine_secrets.this

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
  content  = data.talos_client_configuration.this.talos_config
  filename = "talosconfig"
}
