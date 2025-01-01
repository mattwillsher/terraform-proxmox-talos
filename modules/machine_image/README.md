# terraform-proxmox-talos/modules/image

Downloads the Talos installation ISO from an Image Factory, by default including the QEMU Guest Agent.
Optionally takes a list of extensions to include.
Support Secure Boot, which is enabled by default.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.10)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

- <a name="requirement_talos"></a> [talos](#requirement\_talos) (~> 0.7.0)

## Providers

The following providers are used by this module:

- <a name="provider_talos"></a> [talos](#provider\_talos) (0.7.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [talos_image_factory_schematic.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/image_factory_schematic) (resource)
- [talos_image_factory_extensions_versions.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_extensions_versions) (data source)
- [talos_image_factory_urls.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_urls) (data source)
- [talos_image_factory_versions.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_versions) (data source)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_disable_qemu_guest_agent"></a> [disable\_qemu\_guest\_agent](#input\_disable\_qemu\_guest\_agent)

Description: Disable the inclusion of the qemu-guest-agent extension.

Type: `bool`

Default: `false`

### <a name="input_extensions"></a> [extensions](#input\_extensions)

Description: List of extensions in the image. qemu-guest-agent is included by default.

Type: `list(string)`

Default: `[]`

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

### <a name="output_installer"></a> [installer](#output\_installer)

Description: Machine image for Talos install/update

### <a name="output_iso_url"></a> [iso\_url](#output\_iso\_url)

Description: URL for the Talos ISO image.

### <a name="output_schematic_id"></a> [schematic\_id](#output\_schematic\_id)

Description: Image schematic id.

### <a name="output_talos_version"></a> [talos\_version](#output\_talos\_version)

Description: Selected version of Talos Linux.
<!-- END_TF_DOCS -->
