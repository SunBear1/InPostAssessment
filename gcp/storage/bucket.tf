resource "google_storage_bucket" "cloud_storage_bucket" {
  for_each = local.cloud_storage_buckets

  name = each.value.name

  location                 = each.value.location
  project                  = var.project_id
  storage_class            = var.storage_class
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }
}
