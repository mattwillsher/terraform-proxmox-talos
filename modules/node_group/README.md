<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.6 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.6.0-alpha.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.61.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_vm.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpu_count"></a> [cpu\_count](#input\_cpu\_count) | Number of CPU cores. | `number` | `1` | no |
| <a name="input_cpu_flags"></a> [cpu\_flags](#input\_cpu\_flags) | List of CPU flags. | `list(string)` | `null` | no |
| <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type) | CPU type. | `string` | `"x86-64-v2-AES"` | no |
| <a name="input_create"></a> [create](#input\_create) | Create the node group? | `bool` | `true` | no |
| <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id) | Datastore id for EFI, TPM images. | `string` | `"local-lvm"` | no |
| <a name="input_description"></a> [description](#input\_description) | Node description. | `string` | `null` | no |
| <a name="input_disks"></a> [disks](#input\_disks) | Disks configuration. | `any` | <pre>[<br>  {<br>    "size": 20<br>  }<br>]</pre> | no |
| <a name="input_ipconfig_ipv4"></a> [ipconfig\_ipv4](#input\_ipconfig\_ipv4) | IPv4 address configuration. | `string` | `"dhcp"` | no |
| <a name="input_ipconfig_ipv6"></a> [ipconfig\_ipv6](#input\_ipconfig\_ipv6) | IPv6 address configuration. | `string` | `"dhcp"` | no |
| <a name="input_iso_file_id"></a> [iso\_file\_id](#input\_iso\_file\_id) | Install image ISO file id. | `string` | n/a | yes |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type - controlplane, worker. | `string` | `"worker"` | no |
| <a name="input_memory_size_in_mb"></a> [memory\_size\_in\_mb](#input\_memory\_size\_in\_mb) | Amount of memory in MB. | `number` | `2048` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix for nodes in the node group. | `string` | `"talos"` | no |
| <a name="input_network_devices"></a> [network\_devices](#input\_network\_devices) | Network configuration. | `list(map(string))` | <pre>[<br>  {<br>    "bridge": "vmbr0"<br>  }<br>]</pre> | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Number of nodes in the group. | `number` | `1` | no |
| <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id) | Proxmox resource pool. | `string` | `null` | no |
| <a name="input_pve_node_names"></a> [pve\_node\_names](#input\_pve\_node\_names) | Target PVE nodes to spread node\_group over. | `list(string)` | <pre>[<br>  "pve"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Set of tags for each node. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4_addresses"></a> [ipv4\_addresses](#output\_ipv4\_addresses) | VM Ipv4 addresses. |
| <a name="output_ipv6_addresses"></a> [ipv6\_addresses](#output\_ipv6\_addresses) | VM Ipv6 addresses. |
| <a name="output_mac_addresses"></a> [mac\_addresses](#output\_mac\_addresses) | VM Mac addresses. |
| <a name="output_machine_type"></a> [machine\_type](#output\_machine\_type) | Machine\_type. One of 'controlplane' or 'worker'. |
| <a name="output_names"></a> [names](#output\_names) | VM names. |
| <a name="output_node_count"></a> [node\_count](#output\_node\_count) | Node count. |
<!-- END_TF_DOCS -->