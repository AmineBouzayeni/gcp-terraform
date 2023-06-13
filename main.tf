# Create a single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "jenkins-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ssh", "jenkins"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  # Install Flask
  metadata_startup_script = "set -xe; sudo yum -y install wget; sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo; sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key; sudo yum -y upgrade; sudo yum -y install java-11-openjdk; sudo yum -y install jenkins; sudo systemctl daemon-reload; sudo systemctl start jenkins"

  network_interface {
    subnetwork = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}