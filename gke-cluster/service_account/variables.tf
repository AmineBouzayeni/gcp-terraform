variable "region" {
  description = "GKE cluster and node pool region"
  default = "europe-west1-b"
}

variable "service_account_email" {
  description = "service account email attached to the GKE cluster"
  default = "639824516125-compute@developer.gserviceaccount.com"
}