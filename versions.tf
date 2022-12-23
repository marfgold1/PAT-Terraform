terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

provider "aws" {
    region = "ap-northeast-1"

    default_tags {
        tags = {
            Name = "pat-terraform-demo"
        }
    }
}
