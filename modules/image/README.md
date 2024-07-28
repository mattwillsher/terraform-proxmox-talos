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

- <a name="provider_talos"></a> [talos](#provider\_talos) (0.6.0-alpha.1)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [proxmox_virtual_environment_download_file.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) (resource)
- [random_id.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [talos_image_factory_schematic.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/resources/image_factory_schematic) (resource)
- [talos_image_factory_extensions_versions.this](https://registry.terraform.io/providers/siderolabs/talos/0.6.0-alpha.1/docs/data-sources/image_factory_extensions_versions) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_talos_version"></a> [talos\_version](#input\_talos\_version)

Description: Talos Linux version.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id)

Description: Datastore to store the image in.

Type: `string`

Default: `"local"`

### <a name="input_disable_qemu_guest_agent"></a> [disable\_qemu\_guest\_agent](#input\_disable\_qemu\_guest\_agent)

Description: Do not include the qemu guest agent.

Type: `bool`

Default: `false`

### <a name="input_extensions"></a> [extensions](#input\_extensions)

Description: List of extensions in the image. qemu-guest-agent is included by default.

Type: `list(string)`

Default: `[]`

### <a name="input_factory_host"></a> [factory\_host](#input\_factory\_host)

Description: Image factory hostname.

Type: `string`

Default: `"factory.talos.dev"`

### <a name="input_id"></a> [id](#input\_id)

Description: Unique identifier for the image, postfixed the the generated name. If not set, generate a random id.

Type: `string`

Default: `null`

### <a name="input_pve_node_name"></a> [pve\_node\_name](#input\_pve\_node\_name)

Description: Target node to place the image on.

Type: `string`

Default: `"pve"`

## Outputs

The following outputs are exported:

### <a name="output_installer_image"></a> [installer\_image](#output\_installer\_image)

Description: Machine image for Talos install/update

### <a name="output_iso_file_id"></a> [iso\_file\_id](#output\_iso\_file\_id)

Description: Downloaded file id.
<!-- END_TF_DOCS -->