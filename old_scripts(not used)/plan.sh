#######################################################################################

#!/bin/bash

######################################################################################

# Author        : Apostolos Lazids
# Email         : aplazidis@gmail.com
# Description   : Terraform plan script
# Documentation : https://www.terraform.io/docs/commands/plan.html

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

# The Init command is used to initialize a working directory containing Terraform configuration files.
# This is the first command that should be run after writing a new Terraform configuration
terraform -chdir="$1" init

#The Get command is used to download and update modules mentioned in the root module.
terraform -chdir="$1" get

########################################################################
#       The Plan command is used to create an execution plan           #
########################################################################
PLAN=$(terraform -chdir="$1" plan -json)

#write the result of plan in a txt file
echo $PLAN | grep -o '"@level":"[^"]*' | grep -o '[^"]*$' > plan.txt

INFO="info" #success value
planTxt=$(<plan.txt)

#Loop for find if the txt file has a value called error
while read line
do
    str=$(echo "${line//[$'\t\r\n ']}")     #remove new line values and 
    if [ "$str" != "$INFO" ]; then
        export ERROR="error"
    fi
done < "plan.txt"

############################## check if variable is empty. If not do not continue
if [ ! -z "$ERROR" ]; then 
echo "**********************************************************************************************
**********************************************************************************************
                                    FOUND ERROR
                                    IN EXECUTION PLAN
**********************************************************************************************
**********************************************************************************************"
fi
######################################################################################