#Create an Ansible controller vm
resource "google_compute_instance" "ansible-vm" {
  name         = "ansible-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  # Install Ansible controller, Git & Terraform
  metadata_startup_script = "sudo yum install ansible -y; sudo yum install -y git; sudo yum install -y yum-utils; sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo; sudo yum -y install terraform; curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl; chmod +x ./kubectl; sudo mv ./kubectl /usr/local/bin/kubectl"

  network_interface {
    subnetwork = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}