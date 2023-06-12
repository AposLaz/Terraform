#######################################################################################

#!/bin/bash

######################################################################################

# Author        : DevOps Made Easy
# Email         : aplazidis@gmail.com
# Description   : Terraform destroy script
# Documentation : https://www.terraform.io/docs/commands/destroy.html

######################################################################################

# Export Path Variable
export PATH=$PATH:/opt

######################################################################################

# If statement to ensure a user has provided a Terraform folder path
if [[ -z "$1" ]]; then
echo ""
echo "You have not provided a Terraform path."
echo "SYNTAX = ./destroy.sh <PATH>"
echo "EXAMPLE = ./destroy.sh terraform/instance"
echo ""
exit
fi

######################################################################################

# The Init command is used to initialize a working directory containing Terraform configuration files.
# This is the first command that should be run after writing a new Terraform configuration
terraform -chdir="$1" init

#The Get command is used to download and update modules mentioned in the root module.
terraform -chdir="$1" get

#The Plan command is used to create an execution plan
terraform -chdir="$1" destroy -auto-approve 

######################################################################################