variable "region" {
  description = "GKE cluster and node pool region"
  default = "europe-west1-b"
}

variable "service_account_email" {
  description = "service account email attached to the GKE cluster"
  default = "733491029074-compute@developer.gserviceaccount.com"
}