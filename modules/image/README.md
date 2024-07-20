<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.6 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.6.0-alpha.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.61.1 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.6.0-alpha.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_download_file.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource |
| [talos_image_factory_schematic.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/resources/image_factory_schematic) | resource |
| [talos_image_factory_extensions_versions.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/data-sources/image_factory_extensions_versions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id) | Datastore to store the image in. | `string` | `"local"` | no |
| <a name="input_disable_qemu_guest_agent"></a> [disable\_qemu\_guest\_agent](#input\_disable\_qemu\_guest\_agent) | Do not include the qemu guest agent. | `bool` | `false` | no |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | List of extensions in the image. qemu-guest-agent is included by default. | `list(string)` | `[]` | no |
| <a name="input_factory_host"></a> [factory\_host](#input\_factory\_host) | Image factory hostname. | `string` | `"factory.talos.dev"` | no |
| <a name="input_pve_node_name"></a> [pve\_node\_name](#input\_pve\_node\_name) | Target node to place the image on. | `string` | `"pve"` | no |
| <a name="input_talos_version"></a> [talos\_version](#input\_talos\_version) | Talos Linux version. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_installer_image"></a> [installer\_image](#output\_installer\_image) | Machine image for Talos install/update |
| <a name="output_iso_file_id"></a> [iso\_file\_id](#output\_iso\_file\_id) | Downloaded file id. |
<!-- END_TF_DOCS -->