locals {
  cloud_run_config = { for entry in var.cloud_run_apps : "${entry.name}-${entry.region}" => entry }
}
