###################################################################################
#                             ** Output Variables **                              #
#                                                                                 #
#                                                                                 #
# Output variables are used for organize data to be easily queried and displayed  #
# to the Terraform user.                                                          #
#                                                                                 #
# When building complex infrastructure, Terraform stores hundreds or thousands of #
# attribute values for all your resources. As a user of Terraform, you may only   #
# be interested in a few values of importance. Outputs designate which data to    #
# display. This data is outputted when apply is called, and can be queried using  #
# the terraform output command.                                                   #
#                                                                                 #
#                                                                                 #
###################################################################################


output "machine_type" {
  value = google_compute_instance.default.*.machine_type
}

output "name" {
  value = google_compute_instance.default.*.name
}

output "zone" {
  value = google_compute_instance.default.*.zone
}

output "instance_id" {
  value = join(",", google_compute_instance.default.*.id)
}