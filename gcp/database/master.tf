resource "google_sql_database_instance" "master" {
  name             = "${var.name}-master"
  project          = var.project_id
  database_version = var.database_version
  region           = var.region

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_type         = var.disk_type
  }
}

resource "google_sql_database" "master_db" {
  name     = var.db_name
  project  = var.project_id
  instance = google_sql_database_instance.master.name

  depends_on = [google_sql_database_instance.master]
}

resource "google_sql_user" "mater_db_user" {
  instance = google_sql_database_instance.master.name
  project  = var.project_id
  name     = "sql-admin"
}
