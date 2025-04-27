resource "google_sql_database_instance" "read" {
  count = var.read_replica_count

  name             = "${var.name}-read-${count.index}"
  project          = var.project_id
  database_version = var.database_version
  region           = var.region

  master_instance_name = google_sql_database_instance.master.name

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_type         = var.disk_type
  }
}

resource "google_sql_database" "read_db" {
  count = var.read_replica_count

  name     = var.db_name
  project  = var.project_id
  instance = google_sql_database_instance.read[count.index].name

}

resource "google_sql_user" "read_db_user" {
  count = var.read_replica_count

  instance = google_sql_database_instance.read[count.index].name
  project  = var.project_id
  name     = "sql-admin"
}
