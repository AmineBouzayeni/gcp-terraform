#Create a vm & install docker on it
resource "google_compute_instance" "docker-vm" {
  name         = "docker-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ssh", "httpd"]
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "638312074107-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  # Install docker
  metadata_startup_script = "sudo yum install -y git"

  network_interface {
    subnetwork = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}

resource google_compute_firewall "httpd" {
  project     = var.gcp_project
  name        = "httpd"
  network     = "default"
  description = "Creates firewall rule for httpd"

  allow {
    protocol  = "tcp"
    ports     = ["8080", "8081"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["httpd"]
}