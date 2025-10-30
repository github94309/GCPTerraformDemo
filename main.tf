provider "google" {
  project = "gcpterraformdemo-476710"
  region  = "asia-south1"
  zone    = "asia-south1-a"
}


resource "google_compute_instance" "vm_instance" {
  count         = 3
  name          = "sriramvm${count.index + 1}"  # sriramvm1, sriramvm2, sriramvm3
  machine_type  = "e2-medium"
  zone          = "asia-south1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["web", "dev"]

  metadata = {
    owner = "sriram"
  }
}

