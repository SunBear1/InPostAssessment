output "artifact_name" {
  value = google_artifact_registry_repository.artifact_registry.name
}

output "artifact_id" {
  value = google_artifact_registry_repository.artifact_registry.id
}
