# GCP authentication file
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
  default = "./auth/playground-s-11-8f42591a-bdae05a9b4f5.json"
}
# define GCP region
variable "gcp_region" {
  type        = string
  description = "GCP region"
  default = "europe-west1"
}
# define GCP project name
variable "gcp_project" {
  type        = string
  description = "GCP project name"
  default     = "playground-s-11-8f42591a"
}