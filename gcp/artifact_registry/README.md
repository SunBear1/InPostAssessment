<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_artifact_registry_repository.artifact_registry](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |
| [google_artifact_registry_repository_iam_member.member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The user-provided description of the repository | `string` | `null` | no |
| <a name="input_format"></a> [format](#input\_format) | The format of packages that are stored in the repository. You can only create alpha formats if you are a member of the alpha user group. | `string` | `"DOCKER"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels for the repository | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The name of the location this repository is located in | `string` | n/a | yes |
| <a name="input_mode"></a> [mode](#input\_mode) | The mode configures the repository to serve artifacts from different sources. Default value is STANDARD\_REPOSITORY. Possible values are: STANDARD\_REPOSITORY, VIRTUAL\_REPOSITORY, REMOTE\_REPOSITORY | `string` | `"STANDARD_REPOSITORY"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to create the repository | `string` | n/a | yes |
| <a name="input_repository_id"></a> [repository\_id](#input\_repository\_id) | The repository name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_artifact_id"></a> [artifact\_id](#output\_artifact\_id) | n/a |
| <a name="output_artifact_name"></a> [artifact\_name](#output\_artifact\_name) | n/a |
<!-- END_TF_DOCS -->