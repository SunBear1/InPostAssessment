resource "google_artifact_registry_repository_iam_member" "member" {
  project    = google_artifact_registry_repository.artifact_registry.project
  location   = google_artifact_registry_repository.artifact_registry.location
  repository = google_artifact_registry_repository.artifact_registry.name
  role       = "roles/artifactregistry.admin"
  member     = "user:lukasz.niedzwiadek@example.com"
}
