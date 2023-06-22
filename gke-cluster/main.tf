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
    tags = ["kube-app"]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}