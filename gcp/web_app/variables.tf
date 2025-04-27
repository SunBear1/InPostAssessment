variable "artifact_registry_id" {
  type        = string
  description = "ID of the artifact registry from which images will be pulled"
}

variable "project_id" {
  type        = string
  description = "ID of the GCP project"
}

variable "cloud_run_apps" {
  type = list(object({
    name               = string
    region             = string
    min_instance_count = number
    max_instance_count = number
    image              = string
    ingress            = string
  }))
}
