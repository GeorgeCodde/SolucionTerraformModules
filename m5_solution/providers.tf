##################################################################################
# TERRAFORM CONFIG
##################################################################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
  backend "s3" {
    bucket = "tfstate-tar-testing-jls"
    key    = "environments/testing/cursoterraform.tfstate"
    region = "us-east-1"

  }
}

##################################################################################
# PROVIDERS
##################################################################################
provider "tls" {
  # Configuration options
}

provider "aws" {
  region = var.aws_region
}
