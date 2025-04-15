//Declaring the required providers. In this case, Using the AWS provider, version 5.37.0, sourced from HashiCorp. 
//This block tells Terraform where to fetch the provider.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

//Define a resource block for an AWS S3 bucket that want to manage with this Terraform script. 
//The bucket argument is set to a variable which will be defined later.
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}


//data block for an AWS S3 bucket that is managed outside of this Terraform script. 
//This allows me to fetch and use data about this external bucket.
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not-managed-by-us"
}

//bucket_name variable. This is used in the resource block to set the bucket argument.
variable "bucket_name" {
  type        = string
  description = "My variable used to set bucket name"
  default     = "my_default_bucket_name"
}

//Output block to output the ID of the bucket that we are managing with this Terraform script.
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

//Local block to create a local variable. This variable is only available within this Terraform project locally.
locals {
  local_example = "This is a local variable"
}

//Module block to include a module that is located in the ./module-ilyass directory.
module "my_module" {
  source = "./module-ilyass"
}
