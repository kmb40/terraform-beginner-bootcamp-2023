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
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  assets_path = var.assets_path
  content_version = var.content_version
}

resource "terratowns_home" "home" {
  name = "How to get fit for life!!!"
  description = <<DESCRIPTION
Fitness is essential for quality, productive, long life! 
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fdq3gz.cloudfront.net"
  town = "missingo"
  content_version = 3
}