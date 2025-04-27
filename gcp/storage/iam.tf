resource "google_storage_bucket_iam_member" "cloud_storage_bucket_iam_member" {
  for_each = local.cloud_storage_buckets

  bucket = google_storage_bucket.cloud_storage_bucket[each.key].name
  member = "user:lukasz.niedzwiadek@example.com"
  role   = "roles/storage.admin"
}
