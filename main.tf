terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
#resource "aws_s3_bucket" "website_bucket" {
#  # Bucket Naming Rules
#  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console
#  bucket = var.bucket_name
#
#  tags = {
#    UserUuid = var.user_uuid
#  }
#}
  cloud {
    organization = "mayvik"
    workspaces {
      name = "Terra-House"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_fitness_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.fitness.public_path
  content_version = var.fitness.content_version
}

resource "terratowns_home" "home" {
  name = "How to get fit for life!!!"
  description = <<DESCRIPTION
Fitness is essential for quality, productive, long life! 
DESCRIPTION
  domain_name = module.home_fitness_hosting.domain_name
  town = "missingo"
  content_version = var.fitness.content_version
}

module "home_bbq_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.bbq.public_path
  content_version = var.bbq.content_version
}

resource "terratowns_home" "bbq" {
  name = "Using a Smoker"
  description = <<DESCRIPTION
Smoked meats are incredible! 
DESCRIPTION
  domain_name = module.home_bbq_hosting.domain_name
  #domain_name = "3fdq3gz.cloudfront.net"
  town = "missingo"
  content_version = var.bbq.content_version
}
