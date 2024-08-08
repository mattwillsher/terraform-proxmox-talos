# terraform-proxmox-talos

This module configures Talos Linux for Proxmox. It is able to set up a cluster from one node to many and has shortcut options to enable commonly requested features.

The module is currently in an alpha development phase - it lacks comprehensive testing and the module and its sub-module are subject to change.

## Features

* Create 1-n control plane nodes
* Create 0-n worker nodes in groups of differing configuration
* Support for per-node group and per-cluster variable configuration
* Label nodes and taint by node group
* Set [control plane VIP][1]
* Use Cilium for the CNI instead of Flannel
* Configure metrics-server for statistics

## Variable scoping

There are two levels at which various variables apply - at the cluster level, which is true for all variables - and at the node group level. The node group level can be added to the controlplane and workers values and will be scoped only to that node groups. If a cluster level variables is also so, the node group level takes precidence. 

Variables that can be applied via the node group level variables are marked `(NG)`

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.8)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

- <a name="requirement_talos"></a> [talos](#requirement\_talos) (0.6.0-alpha.1)

## Providers

The following providers are used by this module:

- <a name="provider_random"></a> [random](#provider\_random) (3.6.2)

- <a name="provider_talos"></a> [talos](#provider\_talos) (0.6.0-alpha.1)

## Modules

The following Modules are called:

### <a name="module_image"></a> [image](#module\_image)

Source: ./modules/image

Version:

### <a name="module_node_groups"></a> [node\_groups](#module\_node\_groups)

Source: ./modules/node_group

Version:

### <a name="module_talos"></a> [talos](#module\_talos)

Source: ./modules/talos

Version:

## Resources

The following resources are used by this module:

- [random_id.cluster_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [talos_machine_secrets.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/resources/machine_secrets) (resource)
- [talos_client_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/data-sources/client_configuration) (data source)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_cilium"></a> [cilium](#input\_cilium)

Description: Install Cilium.

Type: `bool`

Default: `false`

### <a name="input_cilium_cli_version"></a> [cilium\_cli\_version](#input\_cilium\_cli\_version)

Description: Cilium CLI version.

Type: `string`

Default: `"latest"`

### <a name="input_cilium_version"></a> [cilium\_version](#input\_cilium\_version)

Description: Cilium version.

Type: `string`

Default: `null`

### <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint)

Description: Cluster endpoint. Defaults to vip if provided, or else the first control plane addresses.

Type: `string`

Default: `null`

### <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name)

Description: Name of the cluster.

Type: `string`

Default: `null`

### <a name="input_config_patches"></a> [config\_patches](#input\_config\_patches)

Description: Talos Linux Configuration patches as a list of maps. (NG).

Type: `list(any)`

Default: `[]`

### <a name="input_controlplane"></a> [controlplane](#input\_controlplane)

Description: Control plane configuration.

Type: `any`

Default: `{}`

### <a name="input_cpu_count"></a> [cpu\_count](#input\_cpu\_count)

Description: Number of CPU core per node. (NG).

Type: `number`

Default: `2`

### <a name="input_cpu_flags"></a> [cpu\_flags](#input\_cpu\_flags)

Description: List of CPU flags. (NG).

Type: `list(string)`

Default:

```json
[
  "+aes"
]
```

### <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type)

Description: CPU type. (NG).

Type: `string`

Default: `"x86-64-v2-AES"`

### <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id)

Description: Default datastore id for EFI and TPM disks and for disks where not set via the disks values(s) (NG).

Type: `string`

Default: `"local-lvm"`

### <a name="input_disks"></a> [disks](#input\_disks)

Description: Disk map. See node\_group submodule for specifics. Typically only changes to size are needed. (NG).

Type: `list(any)`

Default:

```json
[
  {
    "size": 20
  }
]
```

### <a name="input_extensions"></a> [extensions](#input\_extensions)

Description: List of extensions in the image. qemu-guest-agent is included by default.

Type: `list(string)`

Default: `[]`

### <a name="input_factory_host"></a> [factory\_host](#input\_factory\_host)

Description: Image factory hostname.

Type: `string`

Default: `"factory.talos.dev"`

### <a name="input_image_datastore_id"></a> [image\_datastore\_id](#input\_image\_datastore\_id)

Description: Datastore in which to store the downloadeded ISO image.

Type: `string`

Default: `"local"`

### <a name="input_image_pve_node_name"></a> [image\_pve\_node\_name](#input\_image\_pve\_node\_name)

Description: Target node to place the image on. Defaults to the first value of pve\_node\_names.

Type: `string`

Default: `"pve"`

### <a name="input_installer_image"></a> [installer\_image](#input\_installer\_image)

Description: Image factory image name used for installation. If not set, use the same image version and extensions as the boot ISO.

Type: `string`

Default: `null`

### <a name="input_iso_file_id"></a> [iso\_file\_id](#input\_iso\_file\_id)

Description: Proxmox identifier for the boot ISO. If not set, ISO image for the talos\_version will be downloaded and used. installer\_image must also be provided if this options is used.

Type: `string`

Default: `null`

### <a name="input_memory_size_in_mb"></a> [memory\_size\_in\_mb](#input\_memory\_size\_in\_mb)

Description: Memory size for nodes, in MB, where not otherwise specified. (NG).

Type: `string`

Default: `2048`

### <a name="input_metrics_server"></a> [metrics\_server](#input\_metrics\_server)

Description: Enable metrics server.

Type: `bool`

Default: `false`

### <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels)

Description: Labels to apply to nodes. (NG).

Type: `map(string)`

Default: `{}`

### <a name="input_node_taints"></a> [node\_taints](#input\_node\_taints)

Description: Taints to apply to all nodes. (NG).

Type: `map(string)`

Default: `{}`

### <a name="input_pve_node_names"></a> [pve\_node\_names](#input\_pve\_node\_names)

Description: List of Proxmox node names to distribue the VM over. Placement is round-robin. (NG).

Type: `list(string)`

Default:

```json
[
  "pve"
]
```

### <a name="input_registry_mirrors"></a> [registry\_mirrors](#input\_registry\_mirrors)

Description: Map of mirror name to a list of mirror endpoints.

Type: `map(list(string))`

Default: `null`

### <a name="input_registry_mirrors_override_path"></a> [registry\_mirrors\_override\_path](#input\_registry\_mirrors\_override\_path)

Description: Override the registry mirrors path generation. Overrides detection of '/v2/' in the registry mirror urls.

Type: `bool`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: List of tags for each node. (NG).

Type: `list(string)`

Default: `[]`

### <a name="input_talos_endpoint_hosts"></a> [talos\_endpoint\_hosts](#input\_talos\_endpoint\_hosts)

Description: List of hosts to use in client Talos endpoints list. If not, set, us the IP addresses of the controlplane nodes.

Type: `list(string)`

Default: `null`

### <a name="input_talos_machine_secrets"></a> [talos\_machine\_secrets](#input\_talos\_machine\_secrets)

Description: Talos machine secrets.

Type: `any`

Default: `null`

### <a name="input_talos_version"></a> [talos\_version](#input\_talos\_version)

Description: Talos Linux version.

Type: `string`

Default: `null`

### <a name="input_vip_address"></a> [vip\_address](#input\_vip\_address)

Description: Virtual IP address.

Type: `string`

Default: `null`

### <a name="input_workers"></a> [workers](#input\_workers)

Description: Node groups configuration for workers.

Type: `any`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name)

Description: Cluster name.

### <a name="output_controlplane_ip_addresses"></a> [controlplane\_ip\_addresses](#output\_controlplane\_ip\_addresses)

Description: n/a

### <a name="output_kubeconfig_raw"></a> [kubeconfig\_raw](#output\_kubeconfig\_raw)

Description: Raw kubeconfig.

### <a name="output_machine_configurations"></a> [machine\_configurations](#output\_machine\_configurations)

Description: Machine configurations by node group.

### <a name="output_node_ip_addresses"></a> [node\_ip\_addresses](#output\_node\_ip\_addresses)

Description: n/a

### <a name="output_talos_client_configuration"></a> [talos\_client\_configuration](#output\_talos\_client\_configuration)

Description: n/a
<!-- END_TF_DOCS -->