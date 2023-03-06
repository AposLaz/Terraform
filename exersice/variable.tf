variable "project-id" { default = "lively-shelter-294615"}
variable "machine_type" {
  type = map(string)
  default = {
    "dev"  = "e2-standard-2"
    "prod" = "e2-standard-4"
  }
}
variable "environment" { default = "production" }
