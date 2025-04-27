resource "google_compute_region_network_endpoint_group" "cloud_run_network_endpoint_group" {
  for_each = local.cloud_run_config

  name                  = "neg-${each.value.name}-${each.key}"
  project               = var.project_id
  network_endpoint_type = "SERVERLESS"
  region                = each.value.region
  cloud_run {
    service = google_cloud_run_v2_service.cloud_run[each.key].name
  }
}
