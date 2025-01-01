# terraform-proxmox-talos/modules/proxmox_machine_image_iso

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.8)

- <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) (~> 0.69.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

- <a name="requirement_talos"></a> [talos](#requirement\_talos) (~> 0.7.0)

## Providers

The following providers are used by this module:

- <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) (0.69.0)

- <a name="provider_random"></a> [random](#provider\_random) (3.6.3)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [proxmox_virtual_environment_download_file.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) (resource)
- [random_id.proxmox_file_name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [proxmox_virtual_environment_datastores.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_datastores) (data source)
- [proxmox_virtual_environment_nodes.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_nodes) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_iso_url"></a> [iso\_url](#input\_iso\_url)

Description: URL to download the ISO from.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id)

Description: Datastore to store the image in.

Type: `string`

Default: `"local"`

### <a name="input_file_name_suffix"></a> [file\_name\_suffix](#input\_file\_name\_suffix)

Description: Suffix to append to the Proxmox file name. Set to emptry string to use a random id.

Type: `string`

Default: `null`

### <a name="input_node_name"></a> [node\_name](#input\_node\_name)

Description: Target node to place the image on.

Type: `string`

Default: `"pve"`

## Outputs

The following outputs are exported:

### <a name="output_datastore_id"></a> [datastore\_id](#output\_datastore\_id)

Description: Datastore ID where the downloaded boot ISO file is stored in Proxmox, or null if not downloaded.

### <a name="output_file_id"></a> [file\_id](#output\_file\_id)

Description: ID of the downloaded boot ISO in Proxmox.

### <a name="output_file_name"></a> [file\_name](#output\_file\_name)

Description: Name of the downloaded boot ISO file in Proxmox, or null if not downloaded.
<!-- END_TF_DOCS -->