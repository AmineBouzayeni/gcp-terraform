locals {
  private_key_path = "~/.ssh/id_ed25519"
  ssh_user = "ansible"
}
# Create a single Compute Engine instance
## TODOs: - Add project name
resource "google_compute_instance" "master-vm" {
  name         = "master-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  # Install Jenkins, Ansible
  ## TODOs: -Automate Publish Over SSH plugin install and configuration
  ##        -Automate the config of Github Hooks
  ##        -Automate the config the credentials 
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
    command = "ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} master-worker-setup.yaml"
  }  
}

resource "google_compute_instance" "worker-vm" {
  name         = "worker-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  # Install Jenkins, Ansible
  ## TODOs: -Automate Publish Over SSH plugin install and configuration
  ##        -Automate the config of Github Hooks
  ##        -Automate the config the credentials 
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
    command = "ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} master-worker-setup.yaml"
  }  
}