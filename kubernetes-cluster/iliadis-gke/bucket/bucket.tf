module "storage_tf_iliadis" {
  source = "../../modules/bucket"

  region      = "europe-west3-c"
  bucket_name = "iliadis_bucket"
}
