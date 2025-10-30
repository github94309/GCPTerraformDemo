variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "vm_name" {
  type    = string
  default = "damu727vm"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "image" {
  type    = string
  default = "debian-cloud/debian-12"
}

variable "bucket_name" {
  type        = string
  default     = "gcp-damu727-bucket"
  description = "Base name for the GCS bucket"
}

variable "disk_name" {
  type        = string
  default     = "app-disk"
  description = "Name of the persistent disk"
}

variable "disk_size" {
  type        = number
  default     = 10
  description = "Size of the persistent disk in GB"
}
