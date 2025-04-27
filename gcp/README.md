<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.32.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ar"></a> [ar](#module\_ar) | ./artifact_registry | n/a |
| <a name="module_database"></a> [database](#module\_database) | ./database | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./storage | n/a |
| <a name="module_web_apps"></a> [web\_apps](#module\_web\_apps) | ./web_app | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ar"></a> [ar](#output\_ar) | n/a |
| <a name="output_database"></a> [database](#output\_database) | n/a |
| <a name="output_storage"></a> [storage](#output\_storage) | n/a |
| <a name="output_web_apps"></a> [web\_apps](#output\_web\_apps) | n/a |
<!-- END_TF_DOCS -->