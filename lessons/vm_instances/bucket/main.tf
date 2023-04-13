resource "google_storage_bucket" "bucket" {
  count = 1
  name = "test-bucket-gcp"
  location = ""
}