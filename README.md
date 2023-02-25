# Terraform in Google Cloud Platform

## Instructions

Create a folder with name **credentials** and inside create a json file **secrets.json**

The tree path should be:

```bash

$ tree
.
├── vm_instances/
│   ├── credentials/        <------ here is credentials folder
|   |   └── secrets.json
│   ├── first_instance/
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   └── variable.tf
│   ├── apply.sh
│   ├── plan.sh
│   └── destroy.sh
├── .gitignore
└── README.md

```
> **secrets.json** contain the API key for your relative project in GCP. API key is a unique alphanumeric string that associates your Google billing account with your project, and with the specific API or SDK. Follow the instructions from original tutorial for set up and get API key [_https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build_](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build_)

