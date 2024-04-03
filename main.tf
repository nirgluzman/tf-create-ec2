# https://registry.terraform.io/browse/providers
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
  ## profile = "my-profile"
}

resource "aws_instance" "tf-ec2" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"
  key_name = "ec2-key" #  Key name of the Key Pair stored on AWS to use for the instance
  tags = {
    "Name" = "created-by-tf"
  }
}

output "tf-ec2_public_ip" {
  value = "${aws_instance.tf-ec2.public_ip}"
}

resource "aws_eip" "ip" {
  domain = "vpc"
  instance = aws_instance.tf-ec2.id
}
