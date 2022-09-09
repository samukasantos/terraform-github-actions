terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "sample-terraform-bucket-sme-remote-state"
    key    = "pipeline-github-actions/terraform.tfstate"

  }
}

provider "aws" {
  region = local.region

  default_tags {
    tags = {
      "owner"      = "Sam"
      "managed-by" = "terraform"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "sample-terraform-bucket-sme-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "ap-southeast-2"
  }
}