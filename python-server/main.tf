#Create a vm & install docker on it
resource "google_compute_instance" "python-vm" {
  name         = "docker-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  # Install python
  metadata_startup_script = ""

  network_interface {
    subnetwork = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}