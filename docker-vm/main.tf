#Create a vm & install docker on it
resource "google_compute_instance" "docker-vm" {
  name         = "docker-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  # Install docker
  metadata_startup_script = "sudo yum install docker -y; sudo systemctl enable docker; sudo systemctl start docker"

  network_interface {
    subnetwork = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}