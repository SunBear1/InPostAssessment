locals {
  cloud_storage_buckets = { for entry in var.storage_buckets : entry.name => entry }
}