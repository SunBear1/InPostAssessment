resource "google_cloud_run_v2_service" "cloud_run" {
  for_each = local.cloud_run_config

  name                = "cloudrun-${each.value.name}-${each.value.region}"
  location            = each.value.region
  deletion_protection = true
  ingress             = each.value.ingress
  project             = var.project_id

  template {
    scaling {
      min_instance_count = each.value.min_instance_count
      max_instance_count = each.value.max_instance_count
    }
    containers {
      image = "${var.artifact_registry_id}/${each.value.image}"
    }
  }
}
