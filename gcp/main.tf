resource "google_project" "project" {
  name       = "InPost SaaS"
  project_id = "inpost-saas"
}

module "ar" {
  source = "./artifact_registry"

  location      = "us-east4"
  project_id    = google_project.project.project_id
  repository_id = "inpost"
}

module "web_apps" {
  source = "./web_app"

  artifact_registry_id = module.ar.artifact_id
  project_id           = google_project.project.project_id

  cloud_run_apps = [
    {
      name               = "nginx"
      region             = "us-east4"
      min_instance_count = 1
      max_instance_count = 10
      image              = "nginx"
      ingress            = "INGRESS_TRAFFIC_ALL"
    },
    {
      name               = "webapp"
      region             = "us-east4"
      min_instance_count = 1
      max_instance_count = 5
      image              = "webapp"
      ingress            = "INGRESS_TRAFFIC_INTERNAL_ONLY"
    }
  ]
}

module "database" {
  source = "./database"

  availability_type  = "REGIONAL"
  database_version   = "POSTGRES_17"
  db_name            = "inpost"
  disk_type          = "PD_SSD"
  name               = "inpost-sql"
  project_id         = google_project.project.project_id
  read_replica_count = 2
  region             = "us-east4"
  tier               = "db-f1-micro"
}

module "storage" {
  source     = "./storage"
  project_id = google_project.project.project_id
  storage_buckets = [
    {
      name     = "inpost-logs"
      location = "us-east4"
    },
    {
      name     = "inpost-logs-backup"
      location = "europe-west3"
    }
  ]
}
