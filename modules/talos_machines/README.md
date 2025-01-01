# terraform-proxmox-talos/modules/talos

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.8)

- <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) (~> 0.69.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

- <a name="requirement_talos"></a> [talos](#requirement\_talos) (~> 0.7.0)

## Providers

The following providers are used by this module:

- <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) (0.69.0)

- <a name="provider_random"></a> [random](#provider\_random) (3.6.3)

- <a name="provider_talos"></a> [talos](#provider\_talos) (0.7.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [proxmox_virtual_environment_vm.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) (resource)
- [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [talos_machine_configuration_apply.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_configuration_apply) (resource)
- [talos_machine_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/machine_configuration) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint)

Description: Cluster endpoint.

Type: `string`

### <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name)

Description: Name of the cluster.

Type: `string`

### <a name="input_iso_file_id"></a> [iso\_file\_id](#input\_iso\_file\_id)

Description: Install image ISO file id.

Type: `string`

### <a name="input_machine_install_image"></a> [machine\_install\_image](#input\_machine\_install\_image)

Description: Talos install image as used in the machine configuration.

Type: `string`

### <a name="input_machine_secrets"></a> [machine\_secrets](#input\_machine\_secrets)

Description: Talos machine secrets.

Type:

```hcl
object({
    client_configuration = map(string)
    id                   = string
    machine_secrets      = any
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_apply"></a> [apply](#input\_apply)

Description: Apply the configuration.

Type: `bool`

Default: `true`

### <a name="input_cluster_extra_manifests"></a> [cluster\_extra\_manifests](#input\_cluster\_extra\_manifests)

Description: List of URLs of extra manifests to apply to the cluster at bootstrap.

Type: `list(string)`

Default: `[]`

### <a name="input_config_patches"></a> [config\_patches](#input\_config\_patches)

Description: Additional config patches.

Type: `list(string)`

Default: `[]`

### <a name="input_cpu_count"></a> [cpu\_count](#input\_cpu\_count)

Description: Number of CPU cores.

Type: `number`

Default: `1`

### <a name="input_cpu_flags"></a> [cpu\_flags](#input\_cpu\_flags)

Description: List of CPU flags.

Type: `list(string)`

Default: `null`

### <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type)

Description: CPU type.

Type: `string`

Default: `"x86-64-v2-AES"`

### <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id)

Description: Datastore id for EFI, TPM images.

Type: `string`

Default: `"local-lvm"`

### <a name="input_description"></a> [description](#input\_description)

Description: Node description.

Type: `string`

Default: `null`

### <a name="input_disks"></a> [disks](#input\_disks)

Description: Disks configuration.

Type: `any`

Default:

```json
[
  {
    "size": 20
  }
]
```

### <a name="input_is_controlplane"></a> [is\_controlplane](#input\_is\_controlplane)

Description: True is the node group is of control plane node, false otherwise.

Type: `bool`

Default: `false`

### <a name="input_machine_count"></a> [machine\_count](#input\_machine\_count)

Description: Number of machines in the group.

Type: `number`

Default: `1`

### <a name="input_memory_size_in_mb"></a> [memory\_size\_in\_mb](#input\_memory\_size\_in\_mb)

Description: Amount of memory in MB.

Type: `number`

Default: `2048`

### <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix)

Description: Name prefix for nodes in the node group.

Type: `string`

Default: `"talos"`

### <a name="input_network_devices"></a> [network\_devices](#input\_network\_devices)

Description: Network configuration.

Type: `list(map(string))`

Default:

```json
[
  {
    "bridge": "vmbr0"
  }
]
```

### <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels)

Description: Map of node labels to assign to nodes in the node groups.

Type: `map(any)`

Default: `{}`

### <a name="input_node_taints"></a> [node\_taints](#input\_node\_taints)

Description: Map of node taints to assign to nodes in the node groups.

Type: `map(any)`

Default: `{}`

### <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id)

Description: Proxmox resource pool.

Type: `string`

Default: `null`

### <a name="input_proxmox_node_names"></a> [proxmox\_node\_names](#input\_proxmox\_node\_names)

Description: Target PVE nodes to spread node\_group over.

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

Default: `{}`

### <a name="input_registry_mirrors_override_path"></a> [registry\_mirrors\_override\_path](#input\_registry\_mirrors\_override\_path)

Description: Override the registry mirrors path generation. Overrides detection of '/v2/' in the registry mirror urls.

Type: `bool`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Set of tags for each node.

Type: `set(string)`

Default: `[]`

### <a name="input_vip_address"></a> [vip\_address](#input\_vip\_address)

Description: Virtual IP address, only used for contarolplane nodes.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name)

Description: Cluster name.

### <a name="output_config_patches"></a> [config\_patches](#output\_config\_patches)

Description: Config patches used to generate the machine configuration.

### <a name="output_ipv4_addresses"></a> [ipv4\_addresses](#output\_ipv4\_addresses)

Description: VM Ipv4 addresses.

### <a name="output_ipv6_addresses"></a> [ipv6\_addresses](#output\_ipv6\_addresses)

Description: VM Ipv6 addresses.

### <a name="output_mac_addresses"></a> [mac\_addresses](#output\_mac\_addresses)

Description: VM Mac addresses.

### <a name="output_machine_configuration"></a> [machine\_configuration](#output\_machine\_configuration)

Description: Generated Talos machine configuration.

### <a name="output_machine_configuration_applied"></a> [machine\_configuration\_applied](#output\_machine\_configuration\_applied)

Description: Applied Talos machine configuration.

### <a name="output_machine_names"></a> [machine\_names](#output\_machine\_names)

Description: VM names.
<!-- END_TF_DOCS -->
