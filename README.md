<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.8)

## Providers

No providers.

## Modules

The following Modules are called:

### <a name="module_node_groups"></a> [node\_groups](#module\_node\_groups)

Source: ./modules/node_group

Version:

### <a name="module_talos"></a> [talos](#module\_talos)

Source: ./modules/talos

Version:

## Resources

No resources.

## Required Inputs

The following input variables are required:

### <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint)

Description: Cluster endpoint. Defaults to one of the control plane addresses.

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

### <a name="input_cilium"></a> [cilium](#input\_cilium)

Description: Install Cilium.

Type: `bool`

Default: `false`

### <a name="input_cilium_cli_version"></a> [cilium\_cli\_version](#input\_cilium\_cli\_version)

Description: Cilium CLI version

Type: `string`

Default: `"latest"`

### <a name="input_cilium_version"></a> [cilium\_version](#input\_cilium\_version)

Description: Cilium version.

Type: `string`

Default: `null`

### <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name)

Description: Name of the cluster.

Type: `string`

Default: `null`

### <a name="input_config_patches"></a> [config\_patches](#input\_config\_patches)

Description: Configuration patches for all nodes.

Type: `list(any)`

Default: `[]`

### <a name="input_controlplane"></a> [controlplane](#input\_controlplane)

Description: Control plane configuration.

Type: `any`

Default: `{}`

### <a name="input_cpu_flags"></a> [cpu\_flags](#input\_cpu\_flags)

Description: List of CPU flags.

Type: `list(string)`

Default:

```json
[
  "+aes"
]
```

### <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type)

Description: CPU type.

Type: `string`

Default: `"x86-64-v2-AES"`

### <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id)

Description: Default datastore id.

Type: `string`

Default: `"local-lvm"`

### <a name="input_image"></a> [image](#input\_image)

Description: Talos Linux image information.

Type:

```hcl
object({
    iso_file_id     = string
    installer_image = optional(string)
  })
```

Default: `null`

### <a name="input_pve_node_names"></a> [pve\_node\_names](#input\_pve\_node\_names)

Description: List of Proxmox node names to distribue the VM over. Placement is round-robin.

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

### <a name="input_tags"></a> [tags](#input\_tags)

Description: List of tags for each node.

Type: `list(string)`

Default: `[]`

### <a name="input_vip_address"></a> [vip\_address](#input\_vip\_address)

Description: Virtal IP address.

Type: `string`

Default: `null`

### <a name="input_workers"></a> [workers](#input\_workers)

Description: Node groups configuration.

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

### <a name="output_node_ip_addresses"></a> [node\_ip\_addresses](#output\_node\_ip\_addresses)

Description: n/a
<!-- END_TF_DOCS -->