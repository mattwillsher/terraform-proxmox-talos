<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_node_groups"></a> [node\_groups](#module\_node\_groups) | ./modules/node_group | n/a |
| <a name="module_talos"></a> [talos](#module\_talos) | ./modules/talos | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cilium"></a> [cilium](#input\_cilium) | Install Cilium. | `bool` | `false` | no |
| <a name="input_cilium_cli_version"></a> [cilium\_cli\_version](#input\_cilium\_cli\_version) | Cilium CLI version | `string` | `"latest"` | no |
| <a name="input_cilium_version"></a> [cilium\_version](#input\_cilium\_version) | Cilium version. | `string` | `null` | no |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | Cluster endpoint. Defaults to one of the control plane addresses. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster. | `string` | `null` | no |
| <a name="input_config_patches"></a> [config\_patches](#input\_config\_patches) | Configuration patches for all nodes. | `list(any)` | `[]` | no |
| <a name="input_controlplane"></a> [controlplane](#input\_controlplane) | Control plane configuration. | `any` | `{}` | no |
| <a name="input_cpu_flags"></a> [cpu\_flags](#input\_cpu\_flags) | List of CPU flags. | `list(string)` | <pre>[<br>  "+aes"<br>]</pre> | no |
| <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type) | CPU type. | `string` | `"x86-64-v2-AES"` | no |
| <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id) | Default datastore id. | `string` | `"local-lvm"` | no |
| <a name="input_image"></a> [image](#input\_image) | Talos Linux image information. | <pre>object({<br>    iso_file_id     = string<br>    installer_image = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_machine_secrets"></a> [machine\_secrets](#input\_machine\_secrets) | Talos machine secrets. | <pre>object({<br>    client_configuration = map(string)<br>    id                   = string<br>    machine_secrets      = any<br>  })</pre> | n/a | yes |
| <a name="input_pve_node_names"></a> [pve\_node\_names](#input\_pve\_node\_names) | List of Proxmox node names to distribue the VM over. Placement is round-robin. | `list(string)` | <pre>[<br>  "pve"<br>]</pre> | no |
| <a name="input_registry_mirrors"></a> [registry\_mirrors](#input\_registry\_mirrors) | Map of mirror name to a list of mirror endpoints. | `map(list(string))` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags for each node. | `list(string)` | `[]` | no |
| <a name="input_vip_address"></a> [vip\_address](#input\_vip\_address) | Virtal IP address. | `string` | `null` | no |
| <a name="input_workers"></a> [workers](#input\_workers) | Node groups configuration. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster name. |
| <a name="output_controlplane_ip_addresses"></a> [controlplane\_ip\_addresses](#output\_controlplane\_ip\_addresses) | n/a |
| <a name="output_kubeconfig_raw"></a> [kubeconfig\_raw](#output\_kubeconfig\_raw) | Raw kubeconfig. |
| <a name="output_node_ip_addresses"></a> [node\_ip\_addresses](#output\_node\_ip\_addresses) | n/a |
<!-- END_TF_DOCS -->