# GCP authentication file
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
  default = "./auth/playground-s-11-a45bf9d3-07b8de8dbbea.json"
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
  default     = "playground-s-11-a45bf9d3"
}