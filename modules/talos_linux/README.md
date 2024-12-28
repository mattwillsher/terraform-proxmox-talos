# terraform-proxmox-talos/modules/talos

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.8)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

- <a name="requirement_talos"></a> [talos](#requirement\_talos) (~> 0.7.0)

## Providers

The following providers are used by this module:

- <a name="provider_talos"></a> [talos](#provider\_talos) (0.7.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [talos_cluster_kubeconfig.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/cluster_kubeconfig) (resource)
- [talos_machine_bootstrap.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_bootstrap) (resource)
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

### <a name="input_ip_addresses"></a> [ip\_addresses](#input\_ip\_addresses)

Description: List of node IP addresses.

Type: `list(string)`

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

### <a name="input_bootstrap"></a> [bootstrap](#input\_bootstrap)

Description: Bootstrap the cluster.

Type: `bool`

Default: `true`

### <a name="input_cluster_extra_manifests"></a> [cluster\_extra\_manifests](#input\_cluster\_extra\_manifests)

Description: List of URLs of extra manifests to apply to the cluster at bootstrap.

Type: `list(string)`

Default: `[]`

### <a name="input_config_patches"></a> [config\_patches](#input\_config\_patches)

Description: Additional config patches, YAML encoded.

Type: `list(map(any))`

Default: `[]`

### <a name="input_is_controlplane"></a> [is\_controlplane](#input\_is\_controlplane)

Description: True is the node group is of control plane node, false otherwise.

Type: `bool`

Default: `false`

### <a name="input_node_count"></a> [node\_count](#input\_node\_count)

Description: Number of nodes in the group.

Type: `number`

Default: `1`

### <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels)

Description: Map of node labels to assign to nodes in the node groups.

Type: `map(any)`

Default: `{}`

### <a name="input_node_taints"></a> [node\_taints](#input\_node\_taints)

Description: Map of node taints to assign to nodes in the node groups.

Type: `map(any)`

Default: `{}`

### <a name="input_registry_mirrors"></a> [registry\_mirrors](#input\_registry\_mirrors)

Description: Map of mirror name to a list of mirror endpoints.

Type: `map(list(string))`

Default: `{}`

### <a name="input_registry_mirrors_override_path"></a> [registry\_mirrors\_override\_path](#input\_registry\_mirrors\_override\_path)

Description: Override the registry mirrors path generation. Overrides detection of '/v2/' in the registry mirror urls.

Type: `bool`

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

### <a name="output_machine_config_patches"></a> [machine\_config\_patches](#output\_machine\_config\_patches)

Description: Config patches used to generate the machine configuration.

### <a name="output_machine_configuration"></a> [machine\_configuration](#output\_machine\_configuration)

Description: Generated Talos machine configuration.

### <a name="output_machine_configuration_applied"></a> [machine\_configuration\_applied](#output\_machine\_configuration\_applied)

Description: Applied Talos machine configuration.
<!-- END_TF_DOCS -->
