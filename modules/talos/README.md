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

No modules.

## Resources

The following resources are used by this module:

- [random_id.cluster_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [talos_cluster_kubeconfig.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/resources/cluster_kubeconfig) (resource)
- [talos_machine_bootstrap.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/resources/machine_bootstrap) (resource)
- [talos_machine_configuration_apply.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/resources/machine_configuration_apply) (resource)
- [talos_machine_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/data-sources/machine_configuration) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint)

Description: Cluster endpoint.

Type: `string`

### <a name="input_installer_image"></a> [installer\_image](#input\_installer\_image)

Description: Talos installer image.

Type: `string`

### <a name="input_ip_addresses"></a> [ip\_addresses](#input\_ip\_addresses)

Description: List of node IP addresses.

Type: `list(string)`

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

### <a name="input_node_count"></a> [node\_count](#input\_node\_count)

Description: Number of nodes in the group.

Type: `number`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_cilium"></a> [cilium](#input\_cilium)

Description: Install Cilium.

Type: `bool`

Default: `false`

### <a name="input_cilium_cli_version"></a> [cilium\_cli\_version](#input\_cilium\_cli\_version)

Description: Cilium version, set to enable. If not set, uses Talos default CNI.

Type: `string`

Default: `"latest"`

### <a name="input_cilium_version"></a> [cilium\_version](#input\_cilium\_version)

Description: Cilium version, set to enable. If not set, uses Talos default CNI.

Type: `string`

Default: `null`

### <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name)

Description: Name of the cluster.

Type: `string`

Default: `null`

### <a name="input_config_patches"></a> [config\_patches](#input\_config\_patches)

Description: Additional config patches, YAML encoded.

Type: `list(string)`

Default: `[]`

### <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type)

Description: Machine type - controlplane, worker.

Type: `string`

Default: `"worker"`

### <a name="input_registry_mirrors"></a> [registry\_mirrors](#input\_registry\_mirrors)

Description: Map of mirror name to a list of mirror endpoints.

Type: `map(list(string))`

Default: `null`

### <a name="input_vip_address"></a> [vip\_address](#input\_vip\_address)

Description: Virtual IP address, only used for contarolplane nodes.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name)

Description: Cluster name.

### <a name="output_ip_addresses"></a> [ip\_addresses](#output\_ip\_addresses)

Description: Control plane ip addresses.

### <a name="output_kubeconfig_raw"></a> [kubeconfig\_raw](#output\_kubeconfig\_raw)

Description: Raw kubeconfig when machine\_type is controlplane.
<!-- END_TF_DOCS -->