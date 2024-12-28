locals {
  // This code checks if any of the registry mirrors endpoints contain the "/v2/"
  // string. This is used to determine if the overridePath for the registry mirrors
  // should be set to the registry_mirrors_override_path variable or to true.
  mirrors_with_v2 = anytrue(flatten([for k, mirrors in var.registry_mirrors : [for mirror in mirrors : strcontains(mirror, "/v2/")]]))
  machine_install = {
    install = {
      image = var.machine_install_image
      disk  = "/dev/sda"
    }
  }
  machine_registry_mirrors = length(var.registry_mirrors) > 0 ? {
    registries = {
      mirrors = {
        for k, v in var.registry_mirrors : k => {
          endpoints    = v
          overridePath = var.registry_mirrors_override_path != null ? var.registry_mirrors_override_path : local.mirrors_with_v2
        }
      }
    }
  } : {}
  machine_vip = var.is_controlplane && var.vip_address != null ? {
    network = {
      interfaces = [{
        interface = "eth0"
        vip = {
          ip = var.vip_address
        }
      }]
    }
  } : {}
  machine_node_labels = length(var.node_labels) > 0 ? { nodeLabels = var.node_labels } : {}
  machine_node_taints = length(var.node_taints) > 0 ? { nodeTaints = var.node_taints } : {}
  # rotate_certs = var.metrics_server ? {
  #   machine = {
  #     kubelet = {
  #       extraArgs = {
  #         rotate-server-certificates = true
  #       }
  #     }
  #   }
  # } : {}
  // Cluster configuration items
  # cilium = var.cilium && var.machine_type == "controlplane" ? templatefile("${path.module}/templates/cilium.yaml.tftpl", {
  #   version     = var.cilium_version
  #   cli_version = var.cilium_cli_version
  # }) : ""
  # metrics_server = var.metrics_server && var.machine_type == "controlplane" && length(var.metrics_server_manifest_urls) > 0 ? {
  #   cluster = {
  #     extraManifests = var.metrics_server_manifest_urls
  #   }
  # } : {}
  cluster_extra_manifests = length(var.cluster_extra_manifests) > 0 ? { extraManifests = var.cluster_extra_manifests } : {}

  # config_patches = concat([yamlencode(
  #   merge(
  #     local.installer_image,
  #     local.vip,
  #     local.registry_mirrors,
  #     local.node_labels,
  #     local.node_taints,
  #     # local.cilium,
  #     local.extra_manifests,
  #   )
  #   )], var.config_patches
  # )
  machine_config_patches = { machine = merge(
    local.machine_registry_mirrors,
    local.machine_install,
    local.machine_vip,
    local.machine_node_labels,
    local.machine_node_taints,
  ) }
  cluster_config_patches = { cluster = merge(
    local.cluster_extra_manifests
  ) }
  config_patches = concat([
    yamlencode(
      merge(
        local.machine_config_patches,
        var.is_controlplane ? local.cluster_config_patches : {}
      )
    ),
    ],
    [for p in var.config_patches : yamlencode(p)]
  )
}

data "talos_machine_configuration" "this" {
  cluster_name     = var.cluster_name
  cluster_endpoint = var.cluster_endpoint

  machine_type    = var.is_controlplane ? "controlplane" : "worker"
  machine_secrets = var.machine_secrets.machine_secrets

  config_patches = local.config_patches
}

resource "talos_machine_configuration_apply" "this" {
  count = var.node_count * (var.apply ? 1 : 0)

  client_configuration        = var.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.this.machine_configuration

  node = var.ip_addresses[count.index]
}

resource "talos_machine_bootstrap" "this" {
  count = var.is_controlplane && var.apply && var.bootstrap ? 1 : 0

  client_configuration = var.machine_secrets.client_configuration
  node                 = var.ip_addresses[0]

  depends_on = [
    talos_machine_configuration_apply.this
  ]
}

resource "talos_cluster_kubeconfig" "this" {
  count = var.is_controlplane && var.apply && var.bootstrap ? 1 : 0

  client_configuration = var.machine_secrets.client_configuration
  node                 = var.ip_addresses[0]

  depends_on = [
    talos_machine_bootstrap.this
  ]
}
