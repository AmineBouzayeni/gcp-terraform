resource "google_storage_bucket" "static" {
 name          = "amineb_teolia_test_bucket"
 location      = "US"
 storage_class = "STANDARD"

 uniform_bucket_level_access = true
}