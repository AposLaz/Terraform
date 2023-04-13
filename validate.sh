#!/bin/bash

######################################################################################

# Export Path Variable
export PATH=$PATH:/opt

######################################################################################

# If statement to ensure a user has provided a Terraform folder path
if [[ -z "$1" ]]; then
echo ""
echo "You have not provided a Terraform path."
echo "SYNTAX = ./plan.sh <PATH>"
echo "EXAMPLE = ./plan.sh terraform/instance"
echo ""
exit
fi

######################################################################################

#validate terraform

terraform -chdir=$1 validate -json