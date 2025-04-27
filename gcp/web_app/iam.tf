resource "google_cloud_run_v2_service_iam_member" "member" {
  for_each = local.cloud_run_config

  project  = var.project_id
  location = each.value.region
  name     = each.value.name
  role     = "roles/run.admin"
  member   = "user:lukasz.niedziadek@example.com"
}
