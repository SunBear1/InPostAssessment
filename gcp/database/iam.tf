resource "google_project_iam_member" "cloud_sql_admin" {
  member  = "user:luaksz.niedzwiadek@example.com"
  project = var.project_id
  role    = "roles/cloudsql.admin"
}