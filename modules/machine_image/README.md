# terraform-proxmox-talos/modules/image

Downloads the Talos installation ISO from an Image Factory, by default including the QEMU Guest Agent.
Optionally takes a list of extensions to include.
Support Secure Boot, which is enabled by default.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.10)

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

- [proxmox_virtual_environment_download_file.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) (resource)
- [random_id.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [talos_image_factory_schematic.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/image_factory_schematic) (resource)
- [talos_image_factory_extensions_versions.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_extensions_versions) (data source)
- [talos_image_factory_urls.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_urls) (data source)
- [talos_image_factory_versions.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_versions) (data source)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_disable_qemu_guest_agent"></a> [disable\_qemu\_guest\_agent](#input\_disable\_qemu\_guest\_agent)

Description: Do not include the qemu guest agent.

Type: `bool`

Default: `false`

### <a name="input_download_iso"></a> [download\_iso](#input\_download\_iso)

Description: If set to true, download the Talos Linux ISO to the Proxmox datastore.

Type: `bool`

Default: `true`

### <a name="input_extensions"></a> [extensions](#input\_extensions)

Description: List of extensions in the image. qemu-guest-agent is included by default.

Type: `list(string)`

Default: `[]`

### <a name="input_proxmox_datastore_id"></a> [proxmox\_datastore\_id](#input\_proxmox\_datastore\_id)

Description: Datastore to store the image in.

Type: `string`

Default: `"local"`

### <a name="input_proxmox_file_name_suffix"></a> [proxmox\_file\_name\_suffix](#input\_proxmox\_file\_name\_suffix)

Description: Suffix to append to the Proxmox file name to make it unique per run. If not provided, a random suffix is generated.

Type: `string`

Default: `null`

### <a name="input_proxmox_node_name"></a> [proxmox\_node\_name](#input\_proxmox\_node\_name)

Description: Target node to place the image on.

Type: `string`

Default: `"pve"`

### <a name="input_secure_boot"></a> [secure\_boot](#input\_secure\_boot)

Description: Enable secure boot.

Type: `bool`

Default: `true`

### <a name="input_stable_versions_only"></a> [stable\_versions\_only](#input\_stable\_versions\_only)

Description: Select from and check against stable versions only.

Type: `bool`

Default: `true`

### <a name="input_talos_version"></a> [talos\_version](#input\_talos\_version)

Description: Talos Linux version.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_installer_url"></a> [installer\_url](#output\_installer\_url)

Description: Machine image for Talos install/update

### <a name="output_proxmox_datastore_id"></a> [proxmox\_datastore\_id](#output\_proxmox\_datastore\_id)

Description: Datastore ID where the downloaded boot ISO file is stored in Proxmox, or null if not downloaded.

### <a name="output_proxmox_iso_file_id"></a> [proxmox\_iso\_file\_id](#output\_proxmox\_iso\_file\_id)

Description: ID of the downloaded boot ISO in Proxmox.

### <a name="output_proxmox_iso_file_name"></a> [proxmox\_iso\_file\_name](#output\_proxmox\_iso\_file\_name)

Description: Name of the downloaded boot ISO file in Proxmox, or null if not downloaded.

### <a name="output_talos_version"></a> [talos\_version](#output\_talos\_version)

Description: Selected version of Talos Linux.
<!-- END_TF_DOCS -->
