locals {
  private_key_path = "~/.ssh/id_ed25519"
  ssh_user = "ansible"
}
# Create train app firewall rule #
## TODOs: - Add project name
resource "google_compute_firewall" "train-app" {
  project     = ""
  name        = "train-app"
  network     = "default"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["3000"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["train"]
}

# Create a production server
## TODOs: - Add project name
##        - Install ansible agent
resource "google_compute_instance" "staging-vm" {
  name         = "staging-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ssh", "train"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  # Install Ansible agent
  metadata_startup_script = "sudo yum install ansible -y"

  network_interface {
    subnetwork = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.network_interface.0.access_config.0.nat_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} systemd.yaml"
  }
}

#Create a production vm
## TODOs: - Add project name
##        - Install ansible agent
resource "google_compute_instance" "production-vm" {
  name         = "production-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ssh", "jenkins", "train"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  # Install Ansible agent
  metadata_startup_script = "sudo yum install ansible -y"

  network_interface {
    subnetwork = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.network_interface.0.access_config.0.nat_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} systemd.yaml"
  }
}