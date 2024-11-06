terraform {
  required_version = "1.9.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web" {
  ami = var.instance_ami

  instance_type = var.instance_type

  tags = var.instance_tags

}

# resource "aws_s3_bucket" "my-bucket" {
#   bucket = "my-bucket-terraform-1232142145351435321432112"

#   tags = {
#     Name = "my-bucket-terraform"

#     Environment = "Dev"

#     Owner = "Me"

#     UpdatedAt = "2022-02-02"
#   }
# }