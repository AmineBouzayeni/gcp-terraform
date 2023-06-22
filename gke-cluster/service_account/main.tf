# #Create the workload identity pool
# resource "google_iam_workload_identity_pool" "github_actions_identity_pool" {
#   workload_identity_pool_id = "github-actions"
#   display_name              = "github actions"
#   description               = "Identity pool for github actions"
#   disabled                  = false
# }
# #Create the identity pool provider
# resource "google_iam_workload_identity_pool_provider" "github-actions-oidc" {
#   workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions_identity_pool.workload_identity_pool_id
#   workload_identity_pool_provider_id = "github-actions-oidc"
#   attribute_mapping                  = {
#     "google.subject" = "assertion.sub"
#   }
#   oidc {
#     issuer_uri        = "https://token.actions.githubusercontent.com/"
#   }
# }
#Create a service account for github
resource "google_service_account" "github-actions-workflow" {
  account_id   = var.gcp_project
  display_name = "Service Account Github Action Workflow"
}
#Give to the github service account the role container.developer(treat it as an identity)
# resource "google_project_iam_binding" "github_binding" {
#   project = var.gcp_project
#   role    = "roles/container.developer"

#   members = [
#     "serviceAccount:${google_service_account.github-actions-workflow.email}",
#   ]
# }
#Give to the github repo the ability to impersonate the service account(treat it as a resource)
resource "google_service_account_iam_binding" "project" {
  role    = "roles/iam.workloadIdentityUser"
  service_account_id = "projects/playground-s-11-73e7618a/serviceAccounts/playground-s-11-73e7618a@playground-s-11-73e7618a.iam.gserviceaccount.com"
  members = [
    "principal://iam.googleapis.com/projects/733491029074/locations/global/workloadIdentityPools/github-actions/subject/mbouzayeni/cicd-pipeline-train-schedule-kubernetes-gke:refs/heads/main",
  ]
}

# output "service_account_id" {
#   value = google_service_account.github-actions-workflow.id
# }

