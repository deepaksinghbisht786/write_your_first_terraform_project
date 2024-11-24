terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Update to the latest compatible version
    }
  }

  required_version = ">= 1.6.0" # Ensure compatibility with newer Terraform versions
}

provider "aws" {
  region = "us-west-2" # Keep the region consistent
}

# Dynamically fetch the latest Amazon Linux 2 AMI for us-west-2
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"] # Owned by Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.latest_amazon_linux.id # Use dynamic AMI lookup
  instance_type = "t2.micro" # Small and cost-effective instance type

  tags = {
    Name = "Terraform_Demo_November2024"
  }
}

