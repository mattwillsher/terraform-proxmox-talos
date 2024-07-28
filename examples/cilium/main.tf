resource "dns_a_record_set" "api_endpoint" {
  zone      = var.dns_zone
  name      = var.cluster_name
  addresses = [var.vip_address]
  ttl       = 60
}

module "cluster" {
  source = "../.."

  cluster_name  = var.cluster_name
  talos_version = "v1.7.5"

  cluster_endpoint = "https://${dns_a_record_set.api_endpoint.name}.${dns_a_record_set.api_endpoint.zone}:6443"

  datastore_id = var.datastore_id

  controlplane = {
    name_prefix = "${var.cluster_name}-controlplane-"
    node_count  = 3
    tags        = ["controlplane"]
  }

  workers = {
    default = {
      name_prefix       = "${var.cluster_name}-worker-"
      node_count        = 3
      memory_size_in_mb = 8192
      tags              = ["worker"]
    }
  }

  vip_address      = var.vip_address
  registry_mirrors = var.registry_mirrors
  cilium           = true
  cilium_version   = "1.15.7"

  metrics_server = true

  tags = [var.cluster_name, "kubernetes", "cilium-example"]
}

resource "local_file" "kubeconfig" {
  content  = module.cluster.kubeconfig_raw
  filename = "kubeconfig"
}

resource "local_file" "talosconfig" {
  content  = module.cluster.talos_client_configuration.talos_config
  filename = "talosconfig"
}
