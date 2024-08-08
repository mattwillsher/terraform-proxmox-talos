locals {
  // This code checks if any of the registry mirrors endpoints contain the "/v2/"
  // string. This is used to determine if the overridePath for the registry mirrors
  // should be set to the registry_mirrors_override_path variable or to true.
  mirrors_with_v2 = anytrue(flatten([for k, mirrors in var.registry_mirrors : [for mirror in mirrors : strcontains(mirror, "/v2/")]]))
  registry_mirrors = var.registry_mirrors == null ? "" : yamlencode({
    machine = {
      registries = {
        mirrors = {
          for k, v in var.registry_mirrors : k => {
            endpoints    = v
            overridePath = var.registry_mirrors_override_path != null ? var.registry_mirrors_override_path : local.mirrors_with_v2
          }
        }
      }
    }
  })
  installer_image = yamlencode({
    machine = {
      install = {
        image = var.installer_image
        disk  = "/dev/sda"
      }
    }
  })
  vip = var.machine_type == "worker" || var.vip_address == null ? "" : yamlencode({
    machine = {
      network = {
        interfaces = [{
          interface = "eth0"
          vip = {
            ip = var.vip_address
          }
        }]
      }
    }
  })
  node_labels = var.node_labels != {} ? yamlencode({
    machine = {
      nodeLabels = var.node_labels
    }
  }) : ""
  node_taints = var.node_taints != {} ? yamlencode({
    machine = {
      nodeTaints = var.node_taints
    }
  }) : ""
  rotate_certs = var.metrics_server ? yamlencode({
    machine = {
      kubelet = {
        extraArgs = {
          rotate-server-certificates = true
        }
      }
    }
  }) : ""
  // Cluster configuration items
  cilium = var.cilium && var.machine_type == "controlplane" ? templatefile("${path.module}/templates/cilium.yaml.tftpl", {
    version     = var.cilium_version
    cli_version = var.cilium_cli_version
  }) : ""
  metrics_server = var.metrics_server && var.machine_type == "controlplane" && length(var.metrics_server_manifest_urls) > 0 ? yamlencode({
    cluster = {
      extraManifests = var.metrics_server_manifest_urls
    }
  }) : ""
  extra_manifests = length(var.extra_manifests) > 0 ? yamlencode({
    cluster = {
      extraManifests = var.extra_manifests
    }
  }) : ""
}

data "talos_machine_configuration" "this" {
  cluster_name     = var.cluster_name
  cluster_endpoint = var.cluster_endpoint

  machine_type    = var.machine_type
  machine_secrets = var.machine_secrets.machine_secrets

  config_patches = concat(var.config_patches, [
    local.installer_image,
    local.vip,
    local.registry_mirrors,
    local.rotate_certs,
    local.node_labels,
    local.node_taints,
    local.cilium,
    local.metrics_server,
    local.extra_manifests,
  ])
}

resource "talos_machine_configuration_apply" "this" {
  count = var.node_count

  client_configuration        = var.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.this.machine_configuration

  node = var.ip_addresses[count.index]
}

// Bootstrap the first control plane node
resource "talos_machine_bootstrap" "this" {
  count = var.machine_type == "controlplane" ? 1 : 0

  depends_on = [
    talos_machine_configuration_apply.this
  ]
  client_configuration = var.machine_secrets.client_configuration
  node                 = var.ip_addresses[0]
}

resource "talos_cluster_kubeconfig" "this" {
  count = var.machine_type == "controlplane" ? 1 : 0
  depends_on = [
    talos_machine_bootstrap.this
  ]
  client_configuration = var.machine_secrets.client_configuration
  node                 = var.ip_addresses[0]
}
