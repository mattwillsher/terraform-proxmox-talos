data "talos_client_configuration" "this" {
  cluster_name         = module.cluster.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = module.cluster.controlplane_ip_addresses
  nodes                = module.cluster.node_ip_addresses
}

resource "talos_machine_secrets" "this" {}

module "image" {
  source        = "../../modules/image"
  talos_version = "v1.7.5"
}

module "cluster" {
  source = "../.."

  datastore_id = "nvme-data"

  image           = module.image # Pass the full output of the image module.
  machine_secrets = talos_machine_secrets.this

  workers = {
    default = {
      node_count        = 3
      memory_size_in_mb = 4096
      tags              = ["worker"]
    }
  }

  tags = ["kubernetes"]
}

resource "local_file" "kubeconfig" {
  content  = module.cluster.kubeconfig_raw
  filename = "kubeconfig"
}

resource "local_file" "talosconfig" {
  content  = data.talos_client_configuration.this.talos_config
  filename = "talosconfig"
}
