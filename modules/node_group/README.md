<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.8)

- <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) (~> 0.6)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

- <a name="requirement_talos"></a> [talos](#requirement\_talos) (0.6.0-alpha.1)

## Providers

The following providers are used by this module:

- <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) (0.61.1)

- <a name="provider_random"></a> [random](#provider\_random) (3.6.2)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [proxmox_virtual_environment_vm.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) (resource)
- [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_iso_file_id"></a> [iso\_file\_id](#input\_iso\_file\_id)

Description: Install image ISO file id.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

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

### <a name="input_create"></a> [create](#input\_create)

Description: Create the node group?

Type: `bool`

Default: `true`

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

### <a name="input_ipconfig_ipv4"></a> [ipconfig\_ipv4](#input\_ipconfig\_ipv4)

Description: IPv4 address configuration.

Type: `string`

Default: `"dhcp"`

### <a name="input_ipconfig_ipv6"></a> [ipconfig\_ipv6](#input\_ipconfig\_ipv6)

Description: IPv6 address configuration.

Type: `string`

Default: `"dhcp"`

### <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type)

Description: Machine type - controlplane, worker.

Type: `string`

Default: `"worker"`

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

### <a name="input_node_count"></a> [node\_count](#input\_node\_count)

Description: Number of nodes in the group.

Type: `number`

Default: `1`

### <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id)

Description: Proxmox resource pool.

Type: `string`

Default: `null`

### <a name="input_pve_node_names"></a> [pve\_node\_names](#input\_pve\_node\_names)

Description: Target PVE nodes to spread node\_group over.

Type: `list(string)`

Default:

```json
[
  "pve"
]
```

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Set of tags for each node.

Type: `set(string)`

Default: `[]`

## Outputs

The following outputs are exported:

### <a name="output_ipv4_addresses"></a> [ipv4\_addresses](#output\_ipv4\_addresses)

Description: VM Ipv4 addresses.

### <a name="output_ipv6_addresses"></a> [ipv6\_addresses](#output\_ipv6\_addresses)

Description: VM Ipv6 addresses.

### <a name="output_mac_addresses"></a> [mac\_addresses](#output\_mac\_addresses)

Description: VM Mac addresses.

### <a name="output_machine_type"></a> [machine\_type](#output\_machine\_type)

Description: Machine\_type. One of 'controlplane' or 'worker'.

### <a name="output_names"></a> [names](#output\_names)

Description: VM names.

### <a name="output_node_count"></a> [node\_count](#output\_node\_count)

Description: Node count.
<!-- END_TF_DOCS -->