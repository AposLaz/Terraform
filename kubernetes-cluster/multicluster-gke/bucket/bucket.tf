module "storage_multicluster" {
  source = "../../modules/bucket"

  region      = "europe-west8"
  bucket_name = "multicluster_bucket"
}
