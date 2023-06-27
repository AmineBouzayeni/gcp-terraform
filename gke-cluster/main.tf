resource "google_compute_firewall" "kube-app" {
  project     = ""
  name        = "kube-app"
  network     = "default"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["30080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["kube-app"]
}

resource "google_compute_firewall" "kube-canary" {
  project     = ""
  name        = "kube-canary"
  network     = "default"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["30081"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["kube-canary"]
}

resource "google_container_cluster" "primary" {
  name               = "amineb-cluster"
  location           = var.region
  initial_node_count = 3
  
  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      environment = "development"
    }
    tags = ["kube-app", "kube-canary"]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}