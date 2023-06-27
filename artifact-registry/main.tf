resource "google_artifact_registry_repository" "amineb-repo" {
  location      = "europe-west1"
  repository_id = "amineb-repo"
  description   = "Amine B repo in GCP"
  format        = "DOCKER"
}