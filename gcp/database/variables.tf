variable "project_id" {
  type        = string
  description = "ID of the GCP project"
}

variable "name" {
  type        = string
  description = "Name of the database instance"
}

variable "tier" {
  type        = string
  description = "Tier of database machine"
}

variable "database_version" {
  type        = string
  description = "Version on the database"
}

variable "region" {
  type        = string
  description = "Region in which database will be deployed"
}

variable "db_name" {
  type        = string
  description = "Name of the database within the instance"
}

variable "disk_type" {
  type        = string
  description = "Disk type of the instance"
}

variable "availability_type" {
  type        = string
  description = "Availability type of the database"
}

variable "read_replica_count" {
  type        = number
  description = "Number of non-master database instance replicas"
}