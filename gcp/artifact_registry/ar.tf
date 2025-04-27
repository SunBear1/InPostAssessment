resource "google_artifact_registry_repository" "artifact_registry" {
  repository_id = var.repository_id
  location      = var.location
  format        = var.format
  project       = var.project_id
  mode          = var.mode
  description   = var.description
  labels        = var.labels
}
