provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Generate a random ID for unique bucket names
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Create a Compute Engine VM
resource "google_compute_instance" "vm_instance" {
 count  = 4 
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {}

  tags = ["web", "dev"]
}

#Create two Google Cloud Storage buckets
resource "google_storage_bucket" "app_bucket" {
  count         = 2 
  # Ensure the name is unique by including the count.index
  # e.g., bucket-app-0-abcd and bucket-app-1-abcd
  name          = "${var.bucket_name}-${count.index}-${random_id.bucket_suffix.hex}"
  location      = var.region
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  uniform_bucket_level_access = true
}

# Create a persistent disk
resource "google_compute_disk" "app_disk" {
  name = var.disk_name
  type = "pd-standard"
  zone = var.zone
  size = var.disk_size
}

# Attach persistent disk to the VM
resource "google_compute_attached_disk" "vm_disk_attachment" {
  disk     = google_compute_disk.app_disk.id
  instance = google_compute_instance.vm_instance.id
}
