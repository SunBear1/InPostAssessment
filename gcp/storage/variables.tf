variable "project_id" {
  type        = string
  description = "ID of the GCP project"
}

variable "storage_buckets" {
  type = list(object({
    name     = string
    location = string
  }))
}

variable "storage_class" {
  description = "Storage Class of the new cloud storage bucket"
  type        = string
  default     = "STANDARD"
}