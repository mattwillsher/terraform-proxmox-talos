<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.6.0-alpha.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.6.0-alpha.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_id.cluster_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [talos_cluster_kubeconfig.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/resources/cluster_kubeconfig) | resource |
| [talos_machine_bootstrap.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/resources/machine_bootstrap) | resource |
| [talos_machine_configuration_apply.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/data-sources/machine_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cilium"></a> [cilium](#input\_cilium) | Install Cilium. | `bool` | `false` | no |
| <a name="input_cilium_cli_version"></a> [cilium\_cli\_version](#input\_cilium\_cli\_version) | Cilium version, set to enable. If not set, uses Talos default CNI. | `string` | `"latest"` | no |
| <a name="input_cilium_version"></a> [cilium\_version](#input\_cilium\_version) | Cilium version, set to enable. If not set, uses Talos default CNI. | `string` | `null` | no |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | Cluster endpoint. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster. | `string` | `null` | no |
| <a name="input_config_patches"></a> [config\_patches](#input\_config\_patches) | Additional config patches, YAML encoded. | `list(string)` | `[]` | no |
| <a name="input_installer_image"></a> [installer\_image](#input\_installer\_image) | Talos installer image. | `string` | n/a | yes |
| <a name="input_ip_addresses"></a> [ip\_addresses](#input\_ip\_addresses) | List of node IP addresses. | `list(string)` | n/a | yes |
| <a name="input_machine_secrets"></a> [machine\_secrets](#input\_machine\_secrets) | Talos machine secrets. | <pre>object({<br>    client_configuration = map(string)<br>    id                   = string<br>    machine_secrets      = any<br>  })</pre> | n/a | yes |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type - controlplane, worker. | `string` | `"worker"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Number of nodes in the group. | `number` | n/a | yes |
| <a name="input_registry_mirrors"></a> [registry\_mirrors](#input\_registry\_mirrors) | Map of mirror name to a list of mirror endpoints. | `map(list(string))` | `null` | no |
| <a name="input_vip_address"></a> [vip\_address](#input\_vip\_address) | Virtual IP address, only used for contarolplane nodes. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster name. |
| <a name="output_ip_addresses"></a> [ip\_addresses](#output\_ip\_addresses) | Control plane ip addresses. |
| <a name="output_kubeconfig_raw"></a> [kubeconfig\_raw](#output\_kubeconfig\_raw) | Raw kubeconfig when machine\_type is controlplane. |
<!-- END_TF_DOCS -->