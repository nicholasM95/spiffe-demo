terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "jworks-playground"

  default_tags {
    tags = {
      "app" = "nicholas_meyers_spiffe"
    }
  }
}